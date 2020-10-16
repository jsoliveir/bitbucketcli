Function Get-BitbucketBranches{
    param([Parameter(Mandatory=$true)] [PSCustomObject] $Repository)
    
    return (Invoke-RestMethod `
        -Method GET `
        -Uri "$(Get-BitbucketApi)/2.0/repositories/$($Repository.Workspace)/$($Repository.Name)/refs/branches/" `
        -Headers @{ Authorization = "Basic $(Get-BitbucketCredentials)"}).Values `
    | Select-Object `
        @{n="Name";e={$_.name}},`
        @{n="LastCommit";e={$_.target.date}},`
        @{n="Hash";e={$_.target.hash}}
}