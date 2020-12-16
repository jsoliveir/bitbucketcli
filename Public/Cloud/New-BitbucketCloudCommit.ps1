Function New-BitbucketCloudCommit{
    param([Parameter(Mandatory=$false)] [PSCustomObject] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)]  [String]    $Workspace,
          [Parameter(Mandatory=$true)]  [String]    $Repository,
          [Parameter(Mandatory=$false)] [String[]]  $FilesToDelete,
          [Parameter(Mandatory=$false)] [String[]]  $FilesToAdd,
          [Parameter(Mandatory=$false)] [String]    $Message,
          [Parameter(Mandatory=$false)] [String]    $Branch)
          
    $Branch = $Branch -replace "refs/heads/",""
    if($Branch -like $null){
        $Branch = "master"
    }
    $Path = $Path -replace "^/",""
    
    $payload = @()
    $payload += "curl --insecure --fail"
    $payload += "$($Session.Server)/$($Session.Version)/repositories/$Workspace/$Repository/src"
    $payload += "-H 'Authorization: Basic $($Session.Authorization)'"
    $payload += "-H 'ContentType: application/x-www-form-urlencoded'"
    $payload += "-F 'branch=$Branch'"
    $payload += "-F 'message=$Message'"

    foreach($file in $FilesToAdd){
        $paths = $file -split "=>"
        if($paths.Length -ne 2){
            Write-Error `
                "error while attempting to parse files paths"
                throw
        }
        if($paths[0].Trim() -like "http*://*"){
            $src=$paths[0].Trim()
            $dst=$paths[1].Trim()
            $tmp= "./deployment/$(Split-Path -Leaf $dst)"
            try{
                Invoke-WebRequest `
                    -ErrorAction Stop `
                    -UseBasicParsing `
                    -OutFile $tmp `
                    -Uri $src 
            }catch{ throw $_ ; exit -1 }
            $payload += "-F '$dst=@$tmp'"
        }else{
            $src = $paths[0].Trim()
            $dst = $paths[1].Trim()
            $payload += "-F '$dst=@$src'"
        }
    }
    foreach($file in $FilesToDelete){
        $payload += "-F 'files=$file'"
    }
    &([ScriptBlock]::Create($payload -join " "))
    if($LASTEXITCODE -ne 0){
        exit -1
    }
}