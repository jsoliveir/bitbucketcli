Function Get-BitbucketServerRepositoryCommits {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] $ProjectKey,
          [Parameter(Mandatory=$true)] $Repository,
          [Parameter(Mandatory=$false)] $Branch,
          [Parameter(Mandatory=$false)] $Limit = 10 )

    return (Invoke-RestMethod `
        -Method GET `
        -Uri "$($Session.Server)/rest/api/$($Session.Version)/projects/$ProjectKey/repos/$Repository/commits?until=$Branch&limit=$Limit" `
        -Headers @{
            "Content-Type"= "application/json"
            Authorization = $Session.Authorization 
        }).values
}
