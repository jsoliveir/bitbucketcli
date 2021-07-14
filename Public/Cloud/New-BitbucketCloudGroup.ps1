
Function New-BitbucketCloudGroup {
    param(
        [Parameter(Mandatory=$false)] [PSCustomObject] $Session = (Get-BitbucketSession),
        [Parameter(Mandatory=$true)] [String] $Name
    )
    return (Invoke-RestMethod -Method Post `
        -Headers @{Authorization = $Session.Authorization } `
        -Uri "$($Session.Server)/1.0/groups/$($Session.Workspace)" `
        -Body "name=$Name")
}