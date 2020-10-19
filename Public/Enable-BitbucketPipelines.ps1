
Function Enable-BitbucketPipelines{
    param([Parameter(Mandatory=$true)] [PSCustomObject] $Repository)
    Invoke-RestMethod `
        -Method PUT `
        -Uri "$(Get-BitbucketBaseUrl)/repositories/$($Repository.Workspace)/$($Repository.Name)/pipelines_config" `
        -Headers @{ Authorization = "Basic $(Get-BitbucketToken)"} `
        -ContentType "application/json" `
        -Body '{ "enabled":"true" }' `
    | Out-Null
}