Function Remove-BitbucketServerRepositoryRestriction {
    param(
        [Parameter(Mandatory=$false)] [PSCustomObject] $Session = (Get-BitbucketSession),
        [Parameter(Mandatory=$true)] [String] $Project,
        [Parameter(Mandatory=$true)] [String] $Repository,
        [Parameter(Mandatory=$true)] [String] $Id
    )
    
    return (Invoke-RestMethod `
        -Method DELETE `
        -Uri "$($Session.BaseUrl)/rest/branch-permissions/2.0/projects/${Project}/repos/${Repository}/restrictions/${Id}" `
        -Headers @{
            "Content-Type"= "application/json"
            Authorization = $Session.Authorization 
        }).values
}
