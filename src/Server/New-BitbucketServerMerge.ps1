Function New-BitbucketServerMerge {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] $ProjectKey,
          [Parameter(Mandatory=$true)] $Repository,
          [Parameter(Mandatory=$true)] $BranchName,
          [Parameter(Mandatory=$true)] $PullRequestId,
          [Parameter(Mandatory=$true)] $PullRequestVersion)

    return (Invoke-RestMethod `
        -Method POST `
        -Uri "$($Session.BaseUrl)/rest/api/2.0/projects/$ProjectKey/repos/$Repository/pull-requests/$PullRequestId/merge/?version=$PullRequestVersion" `
        -Headers @{
            "Content-Type"= "application/json"
            Authorization = $Session.Authorization 
        }).values
}
