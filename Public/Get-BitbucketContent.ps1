
Function Get-BitbucketContent{
    param([Parameter(Mandatory=$true)] [PSCustomObject] $Repository,
          [Parameter(Mandatory=$true)] [String] $Path,
          [Parameter(Mandatory=$true)] [String] $Branch)

    $Branch = $Branch -replace "refs/heads/",""

    if($Branch -like $null){
        $Branch = (Get-RepositoryBranches -Repository $Repository `
        | Sort-Object LastCommit -Descending `
        | Select-Object -First 1).Name
    }

    $Path = $Path -replace "\\","/"
    $Path = $Path -replace "^/",""
    $Path = $Path -replace "^\.\/",""

    try{
        $request = Invoke-RestMethod `
        -ErrorAction Ignore `
        -Uri "$(Get-BitbucketBaseUrl)/repositories/$($Repository.Workspace)/$($Repository.Name)/src/${Branch}/${Path}" `
        -Headers @{Authorization = "Basic $(Get-BitbucketToken)" } 
    }catch{
        $request = $null
    }

    if($request.Values){
        return $request.Values | Select-Object `
        @{n="Path";e={"/${Path}/$(Split-Path -Leaf $_.path)"}}, `
        @{n="Type";e={$_.type -replace "commit_",""}}, `
        @{n="Brach";e={$Branch}}, `
        @{n="Commit";e={$_.commit.hash}}
    }else{
        return $request
    }
}