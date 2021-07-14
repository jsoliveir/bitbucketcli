
Function Add-BitbucketCloudGroupPriviledge {
    param(
        [Parameter(Mandatory=$false)] [PSCustomObject] $Session = (Get-BitbucketSession),
        [Parameter(Mandatory=$false)] [ValidateSet('read','write','admin')] $Permission = 'read',
        [Parameter(Mandatory=$true)] [String] $Repository,
        [Parameter(Mandatory=$true)] [String] $Group
    )
    return Invoke-RestMethod -Method PUT `
        -Headers @{Authorization = $Session.Authorization } `
        -Uri "$($Session.Server)/1.0/group-privileges/$($Session.Workspace)/$Repository/$($Session.Workspace)/$($Group.ToLower())" `
        -Body "$Permission"
}