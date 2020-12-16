
Function Enable-BitbucketCloudPipelines{
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] $Workspace,
          [Parameter(Mandatory=$true)] $Repository)
    
    Invoke-RestMethod `
        -Method PUT `
        -Uri "$($Session.Server)/$($Session.Version)/repositories/$Workspace/$Repository/pipelines_config" `
        -Headers @{ Authorization = $Session.Authorization} `
        -ContentType "application/json" `
        -Body '{ "enabled":"true" }' `
    | Out-Null
}