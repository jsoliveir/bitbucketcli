Function Set-BitbucketContent{
    param([Parameter(Mandatory=$true)] [PSCustomObject] $Repository,
          [Parameter(Mandatory=$false)] [String[]] $FilesToDelete,
          [Parameter(Mandatory=$false)] [String[]] $FilesToAdd,
          [String] $Message,
          [String] $Branch)
          
    $Branch = $Branch -replace "refs/heads/",""
    if($Branch -like $null){
        $Branch = "master"
    }
    $Path = $Path -replace "^/",""
    
    $payload = @()
    $payload += "curl --insecure --fail"
    $payload += "$(Get-BitbucketApi)/2.0/repositories/$($Repository.Workspace)/$($Repository.Name)/src"
    $payload += "-H 'Authorization: Basic $(Get-BitbucketToken)'"
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