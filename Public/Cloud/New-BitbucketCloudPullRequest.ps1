Function New-BitbucketCloudPullRequest {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] $Workspace,
          [Parameter(Mandatory=$true)] $Repository,
          [Parameter(Mandatory=$true)] $SourceBranch,
          [Parameter(Mandatory=$true)] $TargetBranch,
          [Parameter(Mandatory=$true)] $Description,
          [Parameter(Mandatory=$true)] $Title)
  
        $payload = [PSCustomObject]@{
            "title"=$Title
            "description"=$Description
            "source"= [PSCustomObject]@{
                "branch"=[PSCustomObject]@{
                    "name"= $SourceBranch
                }
            }
            "destination"= [PSCustomObject]@{
                "branch"=[PSCustomObject]@{
                    "name"= $TargetBranch
                }
            }
            "reviewers" = @()
            "close_source_branch"=$false
        }

    return ($payload | ConvertTo-Json | Invoke-RestMethod `
        -Method POST `
        -Uri "$($Session.Server)/$($Session.Version)/repositories/$Workspace/$Repository/pullrequests" `
        -Headers @{
            "Content-Type"= "application/json"
            Authorization = $Session.Authorization 
        }).values
}
