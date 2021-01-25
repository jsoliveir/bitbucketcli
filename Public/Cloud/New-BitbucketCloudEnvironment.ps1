
Function New-BitbucketCloudEnvironment {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] [String] $Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository,
          [Parameter(Mandatory=$true)] [String] $Environment,
          [Parameter(Mandatory=$false)] [String] $Type = "test"
          )

    return Invoke-RestMethod `
    -Method POST `
    -Uri "$($Session.Server)/$($Session.Version)/repositories/$Workspace/$Repository/environments/" `
    -Body "{ 
        `"name`": `"$Environment`",
        `"environment_type`":{
            `"name`":`"$Type`"
         }
    }" `
    -Headers @{
        "Content-Type"= "application/json"
        Authorization = $Session.Authorization 
    }
}