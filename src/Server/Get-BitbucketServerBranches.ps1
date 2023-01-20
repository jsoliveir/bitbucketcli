Function Get-BitbucketServerBranches {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] $ProjectKey,
          [Parameter(Mandatory=$true)] $Repository)
  
    return (Invoke-RestMethod `
        -Method GET `
        -Uri "$($Session.BaseUrl)/rest/api/2.0/projects/$ProjectKey/repos/$Repository/branches" `
        -Headers @{
            "Content-Type"= "application/json"
            Authorization = $Session.Authorization 
        }).values
}
