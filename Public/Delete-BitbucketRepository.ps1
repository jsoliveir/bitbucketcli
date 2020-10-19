Function Delete-BitbucketRepository {
    param(
        [Parameter(Mandatory=$true)] [PSCustomObject] $Repository
    )
 	Write-Host "Deleting repository $($Repository.Name) from $($Repository.ProjectKey) project ..."
    return Invoke-RestMethod -Verbose `
        -Method DELETE `
        -Uri "$(Get-BitbucketBaseUrl)/repositories/$($Repository.Workspace)/$($Repository.Name)" `
        -Headers @{
            "Content-Type"= "application/json"
            Authorization = "Basic $(Get-BitbucketToken)" 
        }
}