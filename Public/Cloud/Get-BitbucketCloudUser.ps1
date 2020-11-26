
Function Get-BitbucketCloudUser {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession))
    return Invoke-RestMethod `
    -Headers @{Authorization = $Session.Authorization } `
    -Uri "$($Session.Server)/$($Session.Version)/user"
}