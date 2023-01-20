Function Get-BitbucketServerFileContent {
    param(
        [Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
        [Parameter(Mandatory=$true)] $ProjectKey,
        [Parameter(Mandatory=$true)] $Repository,
        [Parameter(Mandatory=$true)] $Path
        )

        return (Invoke-RestMethod `
            -Method GET `
            -Uri "$($Session.BaseUrl)/rest/api/2.0/projects/$ProjectKey/repos/$Repository/raw/$($Path)" `
            -Headers @{
                "Content-Type"= "application/json"
                Authorization = $Session.Authorization 
            })
    }
