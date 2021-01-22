Function Get-BitbucketCloudRepositoryVariables {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] [String] $Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository
          )
    return (Invoke-RestMethod `
    -Method GET `
    -Uri "$($Session.Server)/$($Session.Version)/repositories/$Workspace/$Repository/pipelines_config/variables/" `
    -Headers @{
        "Content-Type"= "application/json"
        Authorization = $Session.Authorization 
    }).values
}
