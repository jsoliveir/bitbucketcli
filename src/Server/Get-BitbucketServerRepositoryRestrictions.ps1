Function Get-BitbucketServerRepositoryRestrictions {
    param(
        [Parameter(Mandatory=$false)] [PSCustomObject] $Session = (Get-BitbucketSession),
        [Parameter(Mandatory=$true)] [String] $Project,
        [Parameter(Mandatory=$true)] [String] $Repository
    )
    
    return (Invoke-RestMethod `
        -Method GET `
        -Uri "$($Session.BaseUrl)/rest/branch-permissions/2.0/projects/${Project}/repos/${Repository}/restrictions" `
        -Headers @{
            "Content-Type"= "application/json"
            Authorization = $Session.Authorization 
        }).values
}
