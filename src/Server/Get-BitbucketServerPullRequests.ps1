Function Get-BitbucketServerPullRequests {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] $ProjectKey,
          [Parameter(Mandatory=$true)] $Repository,
          [Parameter(Mandatory=$false)] $BranchName,
          [Parameter(Mandatory=$false)] $Direction = "outgoing")
  

    return (Invoke-RestMethod `
        -Method GET `
        -Uri "$($Session.BaseUrl)/rest/api/2.0/projects/$ProjectKey/repos/$Repository/pull-requests/?at=$BranchName&direction=$Direction" `
        -Headers @{
            "Content-Type"= "application/json"
            Authorization = $Session.Authorization 
        }).values
}
