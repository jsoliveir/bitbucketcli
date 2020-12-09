
Function New-BitbucketCloudTag {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] [String] $Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository,
          [Parameter(Mandatory=$true)] [String] $TagName,
          [Parameter(Mandatory=$false)] [String] $CommitHash)
    return Invoke-RestMethod `
    -Method POST `
    -Uri "$($Session.Server)/$($Session.Version)/repositories/$Workspace/$Repository/refs/tags" `
    -Body "{ `"name`":`"$TagName`", `"target`": { `"hash`":`"$CommitHash`"}  }" `
    -Headers @{
        "Content-Type"= "application/json"
        Authorization = $Session.Authorization 
    }
}