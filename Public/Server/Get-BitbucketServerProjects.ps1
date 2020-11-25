Function Get-BitbucketServerProjects {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession))
    
    return (Invoke-RestMethod -Verbose `
        -Method GET `
        -Uri "$($Session.Server)/rest/api/$($Session.Version)/projects" `
        -Headers @{
            "Content-Type"= "application/json"
            Authorization = "Basic $($Session.AccessToken)" 
        }).values
}
