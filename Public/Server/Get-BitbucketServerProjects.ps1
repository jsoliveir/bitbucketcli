Function Get-BitbucketServerProjects {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession))
    
    return (Invoke-RestMethod `
        -Method GET `
        -Uri "$($Session.Server)/rest/api/$($Session.Version)/projects" `
        -Headers @{
            "Content-Type"= "application/json"
            Authorization = $Session.Authorization 
        }).values
}
