
Function Remove-BitbucketCloudGroup {
    param(
        [Parameter(Mandatory=$false)] [PSCustomObject] $Session = (Get-BitbucketSession),
        [Parameter(Mandatory=$true)] [String] $Group
    )
    return Invoke-RestMethod -Method Delete `
        -Headers @{Authorization = $Session.Authorization } `
        -Uri "$($Session.Server)/1.0/groups/$($Session.Workspace)$($Group.ToLower())" 
}