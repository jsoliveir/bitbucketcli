
Function Get-BitbucketCloudUser {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession))
    return Invoke-RestMethod `
    -Headers @{Authorization = "Basic $($Session.AccessToken)" } `
    -Uri "$($Session.Server)/$($Session.Version)/user"
}