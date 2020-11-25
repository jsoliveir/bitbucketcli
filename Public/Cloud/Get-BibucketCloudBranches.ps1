Function Get-BitbucketCloudBranches{
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] [PSCustomObject] $Repository)
    
    return (Invoke-RestMethod `
        -Method GET `
        -Uri "$($Session.Server)/$($Session.Version)/repositories/$($Repository.Workspace)/$($Repository.Name)/refs/branches/" `
        -Headers @{ Authorization = "Basic $($Session.AccessToken)"}).Values `
    | Select-Object `
        @{n="Name";e={$_.name}},`
        @{n="LastCommit";e={$_.target.date}},`
        @{n="Hash";e={$_.target.hash}}
}