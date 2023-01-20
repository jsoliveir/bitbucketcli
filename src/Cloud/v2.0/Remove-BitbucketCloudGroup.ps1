
Function Remove-BitbucketCloudGroup {
    param(
        [Parameter(Mandatory=$false)] [PSCustomObject] $Session = (Get-BitbucketSession),
        [Parameter(Mandatory=$true)] [String] $Group
    )
    Invoke-RestMethod -Method Delete `
        -Headers @{Authorization = $Session.Authorization } `
        -Uri "$($Session.BaseUrl)/1.0/groups/$($Session.Workspace)/$($Group.ToLower())"
}