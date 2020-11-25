
Function Set-BitbucketCloudRepository {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] [String] $Workspace,
          [Parameter(Mandatory=$true)] [String] $Name,
          [Parameter(Mandatory=$true)] [String] $ProjectKey)
    return Invoke-RestMethod `
    -Method PUT `
    -Uri "$($Session.Server)/$($Session.Version)/repositories/$Workspace/$Name" `
    -Body "{ `"is_private`":true, `"project`": { `"key`":`"$ProjectKey`"} }" `
    -Headers @{
        "Content-Type"= "application/json"
        Authorization = "Basic $($Session.AccessToken)" 
    }
}