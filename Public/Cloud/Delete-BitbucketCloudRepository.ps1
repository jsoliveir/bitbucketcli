Function Delete-BitbucketCloudRepository {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] [PSCustomObject] $Repository)
    
    Write-Host "Deleting repository $($Repository.Name) from $($Repository.ProjectKey) project ..."
    return Invoke-RestMethod -Verbose `
        -Method DELETE `
        -Uri "$($Session.Server)/$($Session.Version)/repositories/$($Repository.Workspace)/$($Repository.Name)" `
        -Headers @{
            "Content-Type"= "application/json"
            Authorization = "Basic $($Session.AccessToken)" 
        }
}
