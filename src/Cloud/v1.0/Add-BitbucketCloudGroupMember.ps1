
Function Add-BitbucketCloudGroupMember {
    param(
        [Parameter(Mandatory=$false)] [PSCustomObject] $Session = (Get-BitbucketSession),
        [Parameter(Mandatory=$true)] [String] $MemberUUID,
        [Parameter(Mandatory=$true)] [String] $Group
    )
    return Invoke-RestMethod -Method PUT `
        -Headers @{Authorization = $Session.Authorization } `
        -Uri "$($Session.BaseUrl)/1.0/groups/$($Session.Workspace)/$($Group.ToLower())/members/$MemberUUID/"
}