Function New-BitbucketServerMerge {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] $ProjectKey,
          [Parameter(Mandatory=$true)] $Repository,
          [Parameter(Mandatory=$true)] $BranchName,
          [Parameter(Mandatory=$true)] $PullRequestId,
          [Parameter(Mandatory=$true)] $PullRequestVersion)

    return (Invoke-RestMethod `
        -Method POST `
        -Uri "$($Session.Server)/rest/api/$($Session.Version)/projects/$ProjectKey/repos/$Repository/pull-requests/$PullRequestId/merge/?version=$PullRequestVersion" `
        -Headers @{
            "Content-Type"= "application/json"
            Authorization = $Session.Authorization 
        }).values
}
