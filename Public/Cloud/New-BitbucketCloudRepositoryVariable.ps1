
Function New-BitbucketCloudRepositoryVariable {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] [String] $Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository,
          [Parameter(Mandatory=$false)] [String] $Key,
          [Parameter(Mandatory=$false)] [String] $Value)
    return Invoke-RestMethod `
    -Method POST `
    -Uri "$($Session.Server)/$($Session.Version)/repositories/$Workspace/$Repository/pipelines_config/variables" `
    -Body "{ `"key`":`"$Key`", `"value`":  `"$Value`" }" `
    -Headers @{
        "Content-Type"= "application/json"
        Authorization = $Session.Authorization 
    }
}

