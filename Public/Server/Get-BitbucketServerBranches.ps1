Function Get-BitbucketServerBranches {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] $ProjectKey,
          [Parameter(Mandatory=$true)] $Repository)
  
    return (Invoke-RestMethod `
        -Method GET `
        -Uri "$($Session.Server)/rest/api/$($Session.Version)/projects/$ProjectKey/repos/$Repository/branches" `
        -Headers @{
            "Content-Type"= "application/json"
            Authorization = $Session.Authorization 
        }).values
}
