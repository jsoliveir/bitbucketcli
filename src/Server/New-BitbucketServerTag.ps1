Function New-BitbucketServerTag {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] $ProjectKey,
          [Parameter(Mandatory=$true)] $Repository,
          [Parameter(Mandatory=$true)] $Name,
          [Parameter(Mandatory=$true)] $StartPoint,
          [Parameter(Mandatory=$true)] $Message)

    $payload = [PSCustomObject] @{
	    "name" = $Name
        "startPoint" = $StartPoint
        "message" = $Message
    }
    return ($payload | ConvertTo-Json | Invoke-RestMethod `
        -Method POST `
        -Uri "$($Session.BaseUrl)/rest/api/2.0/projects/$ProjectKey/repos/$Repository/tags" `
        -Headers @{
            "Content-Type"= "application/json"
            Authorization = $Session.Authorization 
        }).values
}
