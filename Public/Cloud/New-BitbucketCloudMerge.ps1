Function New-BitbucketCloudMerge {
    param([Parameter(Mandatory=$false)] [PSCustomObject] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$false)] [String] $Workspace = $Session.Workspace,
          [Parameter(Mandatory=$true)]  [String] $Repository,
          [Parameter(Mandatory=$true)]  [String]$PullRequestId,
          [Parameter(Mandatory=$false)] [Switch] $CloseBranch=$true,
          [Parameter(Mandatory=$false)] [String] [ValidateSet('squash','merge_commit','fast_forward')] $MergeStrategy='merge_commit',
          [Parameter(Mandatory=$false)] [String] $Message)
      
    $payload = [PSCustomObject]@{
        "close_source_branch" = $CloseBranch
        "merge_strategy" = $MergeStrategy
        "message"  = $Message
    }

    return ($payload | ConvertTo-Json | Invoke-RestMethod `
        -Method POST `
        -Uri "$($Session.Server)/$($Session.Version)/repositories/$Workspace/$Repository/pullrequests/$PullRequestId/merge" `
        -Headers @{
            "Content-Type"= "application/json"
            Authorization = $Session.Authorization 
        })
}
