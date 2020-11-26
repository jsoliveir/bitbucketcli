
Function Get-BitbucketCloudPipelines{
    param(
        [Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
        [Parameter(Mandatory=$true)] [PSCustomObject] $Repository)
 
    return (Invoke-RestMethod `
         -Method GET `
         -Uri "$($Session.Server)/$($Session.Version)/repositories/$($Repository.Workspace)/$($Repository.Name)/pipelines/" `
         -Headers @{ Authorization = $Session.Authorization}).Values
 }