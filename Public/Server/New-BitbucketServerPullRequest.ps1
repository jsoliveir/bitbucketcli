Function New-BitbucketServerPullRequest {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] $ProjectKey,
          [Parameter(Mandatory=$true)] $Repository,
          [Parameter(Mandatory=$true)] $BranchName,
          [Parameter(Mandatory=$true)] $Description,
          [Parameter(Mandatory=$true)] $Title,
          [Parameter(Mandatory=$false)] [ValidateSet('OPEN','CLOSE')] $State = 'OPEN')
  
        $payload = [PSCustomObject]@{
            "title"=$Title
            "description"=$Description
            "state"=$State
            "open"=$true
            "closed"=$false
            "fromRef"= [PSCustomObject]@{
                "id"=$BranchName
                "repository"= [PSCustomObject] @{
                    "slug"=$Repository
                    "project" = [PSCustomObject] @{"key"=$ProjectKey}
                }
            }
            "toRef"= [PSCustomObject]@{
                "id"="refs/heads/master"
                "repository"=[PSCustomObject]@{
                    "slug"=$Repository
                    "project" =[PSCustomObject] @{"key"=$ProjectKey}
                }
            }
            "locked"=$false
        }

    return ($payload | ConvertTo-Json | Invoke-RestMethod `
        -Method POST `
        -Uri "$($Session.Server)/rest/api/$($Session.Version)/projects/$ProjectKey/repos/$Repository/pull-requests/" `
        -Headers @{
            "Content-Type"= "application/json"
            Authorization = $Session.Authorization 
        }).values
}
