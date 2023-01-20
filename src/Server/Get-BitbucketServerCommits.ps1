Function Get-BitbucketServerCommits {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] $ProjectKey,
          [Parameter(Mandatory=$true)] $Repository,
          [Parameter(Mandatory=$false)] $Branch,
          [Parameter(Mandatory=$false)] $Limit = 10 )

    $Branch = [System.Web.HttpUtility]::UrlEncode($Branch)
    return (Invoke-RestMethod `
        -Method GET `
        -Uri "$($Session.BaseUrl)/rest/api/2.0/projects/$ProjectKey/repos/$Repository/commits?until=$Branch&limit=$Limit" `
        -Headers @{
            "Content-Type"= "application/json"
            Authorization = $Session.Authorization 
        }).values
}
