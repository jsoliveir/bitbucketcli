
Function Set-BitbucketCloudGroup {
    param(
        [Parameter(Mandatory=$false)] [PSCustomObject] $Session = (Get-BitbucketSession),
        [Parameter(Mandatory=$true)] [ValidateSet('write','read','admin')] $Permission = "admin",
        [Parameter(Mandatory=$true)] [String] $AutoAdd = $true,
        [Parameter(Mandatory=$true)] [String] $Group
    )

    return Invoke-RestMethod -Method PUT `
        -Headers @{Authorization = $Session.Authorization } `
        -Uri "$($Session.Server)/1.0/groups/$($Session.Workspace)/$($Group.ToLower())" `
        -Body "{
            `"name`":`"$Id`",
            `"permission`":`"$Permission`",
            `"auto_add`": $("$AutoAdd".ToLower())
        }"
}