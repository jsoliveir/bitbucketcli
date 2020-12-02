Function Get-BitbucketServerPullRequests {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] $ProjectKey,
          [Parameter(Mandatory=$true)] $Repository,
          [Parameter(Mandatory=$false)] $BranchName,
          [Parameter(Mandatory=$false)] $Direction = "outgoing")
  

    return (Invoke-RestMethod `
        -Method GET `
        -Uri "$($Session.Server)/rest/api/$($Session.Version)/projects/$ProjectKey/repos/$Repository/pull-requests/?at=$BranchName&direction=$Direction" `
        -Headers @{
            "Content-Type"= "application/json"
            Authorization = $Session.Authorization 
        }).values
}
