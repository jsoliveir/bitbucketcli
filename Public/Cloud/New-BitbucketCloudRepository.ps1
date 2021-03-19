
Function New-BitbucketCloudRepository {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$false)] [String] $Workspace = $Session.Workspace,
          [Parameter(Mandatory=$true)] [String] $Name,
          [Parameter(Mandatory=$false)] [String] $ProjectKey,
          [Parameter(Mandatory=$false)] [switch] $Public,
          [Parameter(Mandatory=$false)] [String] $MainBranch="master")

    $payload = [PSCustomObject] @{
        is_private = ($Public -eq $false)
    }
    
    if($ProjectKey){
        $payload.project = [PSCustomObject]@{
            key = $ProjectKey
        }
    }
    return ($payload | ConvertTo-Json | Invoke-RestMethod `
    -Method POST `
    -Uri "$($Session.Server)/$($Session.Version)/repositories/$Workspace/$Name" `
    -Headers @{
        "Content-Type"= "application/json"
        Authorization = $Session.Authorization 
    })
}