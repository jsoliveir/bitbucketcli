
Function New-BitbucketCloudRepositoryVariable {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$false)] [String] $Workspace = $Session.Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository,
          [Parameter(Mandatory=$false)] [String] $Key,
          [Parameter(Mandatory=$false)] [String] $Value,
          [Parameter(Mandatory=$false)] [Bool] $Secured
          )
    $payload = @{
        uuid=$Key
        key=$Key
        value=$Value
        secured=$Secured
    } 
    return $payload | ConvertTo-Json | Invoke-RestMethod `
    -Method POST `
    -Uri "$($Session.Server)/$($Session.Version)/repositories/$Workspace/$Repository/pipelines_config/variables/" `
    -Headers @{
        "Content-Type"= "application/json"
        Authorization = $Session.Authorization 
    }
}

