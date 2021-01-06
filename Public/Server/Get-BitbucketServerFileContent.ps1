Function Get-BitbucketServerFileContent {
    param(
        [Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
        [Parameter(Mandatory=$true)] $ProjectKey,
        [Parameter(Mandatory=$true)] $Repository,
        [Parameter(Mandatory=$true)] $Path
        )

        return (Invoke-RestMethod `
            -Method GET `
            -Uri "$($Session.Server)/rest/api/$($Session.Version)/projects/$ProjectKey/repos/$Repository/raw/$($Path)" `
            -Headers @{
                "Content-Type"= "application/json"
                Authorization = $Session.Authorization 
            })
    }
