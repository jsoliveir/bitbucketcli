Function New-BitbucketServerRepositoryRestriction {
    param(
        [Parameter(Mandatory=$false)] [PSCustomObject] $Session = (Get-BitbucketSession),
        [Parameter(Mandatory=$true)] [String] $Project,
        [Parameter(Mandatory=$true)] [String] $Repository,
        [Parameter(Mandatory=$true)] [String] $BranchPattern,
        [Parameter(Mandatory=$true)] [String] [ValidateSet('read-only')] $Restriction,
        [Parameter(Mandatory=$false)] [String] $Label
    )
    
    return (Invoke-RestMethod `
        -Method POST `
        -Uri "$($Session.BaseUrl)/rest/branch-permissions/2.0/projects/${Project}/repos/${Repository}/restrictions" `
        -Headers @{
            "Content-Type"= "application/json"
            Authorization = $Session.Authorization 
        } `
        -Body "
        {
            `"type`":  `"$Restriction`",
            `"matcher`": {
                `"id`":  `"$BranchPattern`",
                `"displayId`":`"$Label`",
                `"type`": {
                    `"id`": `"PATTERN`",
                    `"name`": `"Pattern`"
                },
                `"active`": true
            },
            `"users`": [],
            `"groups`": [],
            `"accessKeys`": []
        }").values
}
