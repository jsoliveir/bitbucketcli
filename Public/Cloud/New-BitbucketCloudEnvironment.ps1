
Function New-BitbucketCloudEnvironment {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] [String] $Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository,
          [Parameter(Mandatory=$false)] [String] $Environment)

    return Invoke-RestMethod `
    -Method POST `
    -Uri "$($Session.Server)/$($Session.Version)/repositories/$Workspace/$Repository/environments/" `
    -Body "{ `"name`": `"Repository`" }" `
    -Headers @{
        "Content-Type"= "application/json"
        Authorization = $Session.Authorization 
    }
}