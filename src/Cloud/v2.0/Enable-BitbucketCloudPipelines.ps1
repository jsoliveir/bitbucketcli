
Function Enable-BitbucketCloudPipelines{
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$false)] [String] $Workspace = $Session.Workspace,
          [Parameter(Mandatory=$true)] $Repository)
    
    Invoke-RestMethod `
        -Method PUT `
        -Uri "$($Session.BaseUrl)/2.0/repositories/$Workspace/$Repository/pipelines_config" `
        -Headers @{ Authorization = $Session.Authorization} `
        -ContentType "application/json" `
        -Body '{ "enabled":"true" }' `
    | Out-Null
}