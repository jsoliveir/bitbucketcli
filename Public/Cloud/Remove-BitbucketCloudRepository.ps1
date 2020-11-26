Function Remove-BitbucketCloudRepository {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] $Workspace,
          [Parameter(Mandatory=$true)] $Name)
    
    return Invoke-RestMethod `
        -Method DELETE `
        -Uri "$($Session.Server)/$($Session.Version)/repositories/$Workspace/$Name" `
        -Headers @{
            "Content-Type"= "application/json"
            Authorization = $Session.Authorization 
        }
}
