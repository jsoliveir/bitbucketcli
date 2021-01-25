
Function Remove-BitbucketCloudEnvironment {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] [String] $Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository,
          [Parameter(Mandatory=$true)] [String] $Id
          )

    return Invoke-RestMethod `
    -Method DELETE `
    -Uri "$($Session.Server)/$($Session.Version)/repositories/$Workspace/$Repository/environments/$Id" `
    -Headers @{
        "Content-Type"= "application/json"
        Authorization = $Session.Authorization 
    }
}