
Function New-BitbucketCloudTag {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$false)] [String] $Workspace = $Session.Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository,
          [Parameter(Mandatory=$true)] [String] $TagName,
          [Parameter(Mandatory=$false)] [String] $CommitHash)
    return Invoke-RestMethod `
    -Method POST `
    -Uri "$($Session.BaseUrl)/2.0/repositories/$Workspace/$Repository/refs/tags" `
    -Body "{ `"name`":`"$TagName`", `"target`": { `"hash`":`"$CommitHash`"}  }" `
    -Headers @{
        "Content-Type"= "application/json"
        Authorization = $Session.Authorization 
    }
}