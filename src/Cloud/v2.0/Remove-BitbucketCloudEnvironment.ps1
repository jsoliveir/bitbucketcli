
Function Remove-BitbucketCloudEnvironment {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$false)] [String] $Workspace = $Session.Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository,
          [Parameter(Mandatory=$true)] [String] $Id
          )

    return Invoke-RestMethod `
    -Method DELETE `
    -Uri "$($Session.BaseUrl)/2.0/repositories/$Workspace/$Repository/environments/$Id" `
    -Headers @{
        "Content-Type"= "application/json"
        Authorization = $Session.Authorization 
    }
}