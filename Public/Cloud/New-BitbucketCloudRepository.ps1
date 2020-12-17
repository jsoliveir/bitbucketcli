
Function New-BitbucketCloudRepository {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] [String] $Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository,
          [Parameter(Mandatory=$false)] [String] $ProjectKey,
          [Parameter(Mandatory=$false)] [String] $MainBranch="master")
    return Invoke-RestMethod `
    -Method POST `
    -Uri "$($Session.Server)/$($Session.Version)/repositories/$Workspace/$Name" `
    -Body "{ `"is_private`":true, `"project`": { `"key`":`"$ProjectKey`"}  }" `
    -Headers @{
        "Content-Type"= "application/json"
        Authorization = $Session.Authorization 
    }
}