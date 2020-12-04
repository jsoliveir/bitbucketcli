
Function Get-BitbucketCloudContent{
    param(
          [Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] [String] $Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository,
          [Parameter(Mandatory=$true)] [String] $Path,
          [Parameter(Mandatory=$true)] [String] $Branch
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

    try{
        $request = Invoke-RestMethod `
        -ErrorAction Ignore `
        -Uri "$($Session.Server)/$($Session.Version)/repositories/${Workspace}/${Repository}/src/${Branch}/${Path}" `
        -Headers @{Authorization = $Session.Authorization } 
    }catch{
        $request = $null
    }

    if($request.Values){
        return $request.Values
    }else{
        return $request
    }
}