
Function Get-BitbucketCloudContent{
    param(
          [Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] [String] $Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository,
          [Parameter(Mandatory=$true)] [String] $Path,
          [Parameter(Mandatory=$false)] [String] $Branch="master",
          [Parameter(Mandatory=$false)] [String] $Query,
          [Parameter(Mandatory=$false)] [Int] $PageLen=100
    )

    $Branch = $Branch -replace "refs/heads/",""
    $Path = $Path -replace "\\","/"
    $Path = $Path -replace "^/",""
    $Path = $Path -replace "^\.\/",""

    $request = (Invoke-WebRequest `
        -Uri "$($Session.Server)/$($Session.Version)/repositories/${Workspace}/${Repository}/src/${Branch}/${Path}?q=${Query}&pagelen=${PageLen}" `
        -ContentType "application/json;charset=utf-8" `
        -UseBasicParsing `
        -Headers @{
            Authorization = $Session.Authorization
        })
        
    $json = ($request.Content | ConvertFrom-Json -ErrorAction Ignore);
    if($json.values.path){
        return $json
    }else{
        return $request.Content
    }
}