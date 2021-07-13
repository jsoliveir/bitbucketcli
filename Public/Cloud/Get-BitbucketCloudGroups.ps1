
Function Get-BitbucketCloudGroups {
    param(
        [Parameter(Mandatory=$false)] [PSCustomObject] $Session = (Get-BitbucketSession)
    )
    return Invoke-RestMethod `
        -Headers @{Authorization = $Session.Authorization } `
        -Uri "$($Session.Server)/1.0/groups/$($Session.Workspace)"
}