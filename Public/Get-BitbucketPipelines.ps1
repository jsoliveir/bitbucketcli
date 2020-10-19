
Function Get-BitbucketPipelines{
    param([Parameter(Mandatory=$true)] [PSCustomObject] $Repository)
 
    return (Invoke-RestMethod `
         -Method GET `
         -Uri "$(Get-BitbucketBaseUrl)/repositories/$($Repository.Workspace)/$($Repository.Name)/pipelines/" `
         -Headers @{ Authorization = "Basic $(Get-BitbucketToken)"}).Values
 }