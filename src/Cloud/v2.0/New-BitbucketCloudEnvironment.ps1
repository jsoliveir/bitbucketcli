
Function New-BitbucketCloudEnvironment {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$false)] [String] $Workspace = $Session.Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository,
          [Parameter(Mandatory=$true)] [String] $Environment,
          [Parameter(Mandatory=$false)] [String] $Type = "test"
          )

    return Invoke-RestMethod `
    -Method POST `
    -Uri "$($Session.BaseUrl)/2.0/repositories/$Workspace/$Repository/environments/" `
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