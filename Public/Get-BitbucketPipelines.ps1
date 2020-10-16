
Function Get-BitbucketPipelines{
    param([Parameter(Mandatory=$true)] [PSCustomObject] $Repository)
 
    return (Invoke-RestMethod `
         -Method GET `
         -Uri "$(Get-BitbucketApi)/2.0/repositories/$($Repository.Workspace)/$($Repository.Name)/pipelines/" `
         -Headers @{ Authorization = "Basic $(Get-BitbucketToken)"}).Values
 }