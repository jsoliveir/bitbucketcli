
Function Get-BitbucketCloudContent{
    param(
          [Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] [String] $Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository,
          [Parameter(Mandatory=$true)] [String] $Path,
          [Parameter(Mandatory=$true)] [String] $Branch,
          [Parameter(Mandatory=$false)] [String] $Query,
          [Parameter(Mandatory=$false)] [Int] $PageLen=100
    )

    $Branch = $Branch -replace "refs/heads/",""
    $Path = $Path -replace "\\","/"
    $Path = $Path -replace "^/",""
    $Path = $Path -replace "^\.\/",""

    $request = Invoke-RestMethod `
        -Uri "$($Session.Server)/$($Session.Version)/repositories/${Workspace}/${Repository}/src/${Branch}/${Path}?q=${Query}&pagelen=${PageLen}" `
        -Headers @{Authorization = $Session.Authorization } 

    if($request.values){
        return $request.values
    }else{
        return $request
    }
}