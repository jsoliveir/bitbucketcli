
Function Get-BitbucketCloudEnvironments {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$false)] [String] $Workspace = $Session.Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository)

    return (Invoke-RestMethod `
    -Method GET `
    -Uri "$($Session.Server)/$($Session.Version)/repositories/$Workspace/$Repository/environments/" `
    -Headers @{
        "Content-Type"= "application/json"
        Authorization = $Session.Authorization 
    }).values
}