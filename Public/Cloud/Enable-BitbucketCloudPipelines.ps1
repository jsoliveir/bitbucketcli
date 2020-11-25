
Function Enable-BitbucketCloudPipelines{
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] [PSCustomObject] $Repository)
    
    Invoke-RestMethod `
        -Method PUT `
        -Uri "$($Session.Server)/$($Session.Version)/repositories/$($Repository.Workspace)/$($Repository.Name)/pipelines_config" `
        -Headers @{ Authorization = "Basic $($Session.AccessToken)"} `
        -ContentType "application/json" `
        -Body '{ "enabled":"true" }' `
    | Out-Null
}