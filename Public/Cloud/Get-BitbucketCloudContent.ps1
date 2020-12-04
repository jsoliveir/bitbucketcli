
Function Get-BitbucketCloudContent{
    param(
          [Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] [String] $Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository,
          [Parameter(Mandatory=$true)] [String] $Path,
          [Parameter(Mandatory=$true)] [String] $Branch,
          [Parameter(Mandatory=$false)] $Query,
          [Parameter(Mandatory=$false)] $Page,
          [Parameter(Mandatory=$false)] $PageLen,
          [Parameter(Mandatory=$false)] $Limit=1000
    )

    $Branch = $Branch -replace "refs/heads/",""

    if($Branch -like $null){
        $Branch = (Get-BitbucketCloudBranches -Worspace $Workspace -Repository $Repository `
        | Sort-Object LastCommit -Descending `
        | Select-Object -First 1).Name
    }

    $Path = $Path -replace "\\","/"
    $Path = $Path -replace "^/",""
    $Path = $Path -replace "^\.\/",""

    $request = Invoke-RestMethod `
        -Uri "$($Session.Server)/$($Session.Version)/repositories/${Workspace}/${Repository}/src/${Branch}/${Path}?q=${Query}&page=${Page}&pagelen=${PageLen}&limit=${Limit}" `
        -Headers @{Authorization = $Session.Authorization } 

    if($request.Values){
        return $request.Values
    }else{
        return $request
    }
}