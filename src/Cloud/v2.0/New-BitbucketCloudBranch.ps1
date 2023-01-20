
Function New-BitbucketCloudBranch {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$false)] [String] $Workspace = $Session.Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository,
          [Parameter(Mandatory=$true)] [String] $Name,
          [Parameter(Mandatory=$false)] [String] $CommitHash)
    return Invoke-RestMethod `
    -Method POST `
    -Uri "$($Session.BaseUrl)/2.0/repositories/$Workspace/$Repository/refs/branches" `
    -Body "{ `"name`":`"$Name`", `"target`": { `"hash`":`"$CommitHash`"}  }" `
    -Headers @{
        "Content-Type"= "application/json"
        Authorization = $Session.Authorization 
    }
}