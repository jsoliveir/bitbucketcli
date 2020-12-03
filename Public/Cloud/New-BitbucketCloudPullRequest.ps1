Function New-BitbucketCloudPullRequest {
    param([Parameter(Mandatory=$false)] [PSCustomObject] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] [String] $Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository,
          [Parameter(Mandatory=$true)] [String] $SourceBranch,
          [Parameter(Mandatory=$true)] [String] $TargetBranch,
          [Parameter(Mandatory=$true)] [String] $Description,
          [Parameter(Mandatory=$true)] [String] $Title)
  
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
        })
}
