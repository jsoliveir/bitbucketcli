Function Get-BitbucketServerProjects {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession))
    
    return (Invoke-RestMethod `
        -Method GET `
        -Uri "$($Session.BaseUrl)/rest/api/2.0/projects" `
        -Headers @{
            "Content-Type"= "application/json"
            Authorization = $Session.Authorization 
        }).values
}
