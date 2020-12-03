
Function Get-BitbucketCloudPipelines{
    param(
        [Parameter(Mandatory=$false)] [PSCustomObject] $Session = (Get-BitbucketSession),
        [Parameter(Mandatory=$true)]  [String] $Repository,
        [Parameter(Mandatory=$false)] [String] $Query="")
 
    return (Invoke-RestMethod `
         -Method GET `
         -Uri "$($Session.Server)/$($Session.Version)/repositories/$($Repository.Workspace)/$($Repository.Name)/pipelines/?q=${Query}" `
         -Headers @{ Authorization = $Session.Authorization}).Values
 }