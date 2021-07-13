
Function Set-BitbucketCloudGroup {
    param(
        [Parameter(Mandatory=$false)] [PSCustomObject] $Session = (Get-BitbucketSession),
        [Parameter(Mandatory=$true)] [ValidateSet('write','read','admin')] $Permission = "admin",
        [Parameter(Mandatory=$true)] [String] $AutoAdd = $true,
        [Parameter(Mandatory=$true)] [String] $Id
    )

    return Invoke-RestMethod -Method PUT `
        -Headers @{Authorization = $Session.Authorization } `
        -Uri "$($Session.Server)/1.0/groups/$($Session.Workspace)/$Id" `
        -Body "{
            `"name`":`"$Id`",
            `"permission`":`"$Permission`",
            `"auto_add`": $("$AutoAdd".ToLower())
        }"
}