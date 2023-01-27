Function New-BitbucketCloudBranchRestriction {
  param([Parameter(Mandatory = $false)] [PSCustomObject] $Session = (Get-BitbucketSession),
    [Parameter(Mandatory = $false)] [String] $Workspace = $Session.Workspace,
    [Parameter(Mandatory = $true)]  [String] $Repository,
    [Parameter(Mandatory = $false)]  [String[]] $AllowedGroups,
    [Parameter(Mandatory = $false)]  [String[]] $AllowedUsers,
    [Parameter(Mandatory = $true)]  [String] $Branch
  )
      
  $payload = @{
    type   = "branchrestriction"
    branch_match_kind="glob"
    pattern=$Branch
    kind = "push"
  }

  if($AllowedUsers){
    $payload.Add("users", @($AllowedUsers | ForEach-Object { 
      return @{
        username = $_
      }
    }))
  }

  if($AllowedGroups){
    $payload.Add("groups", @($AllowedGroups | ForEach-Object { 
      return @{
        slug = ($_.Replace(" ","-") -replace "\W","-").ToLower()
      }
    }))
  }

  $BranchRestriction = Get-BitbucketCloudBranchRestrictions `
    -Repository $Repository | Where-Object pattern -like $Branch

  if( $BranchRestriction ){
    return ($payload -as [PSCustomObject] | ConvertTo-Json | Invoke-RestMethod `
      -Uri "$($Session.BaseUrl)/2.0/repositories/$Workspace/$Repository/branch-restrictions/$($BranchRestriction.id)" `
      -Method PUT `
      -Headers @{
      "Content-Type" = "application/json"
      Authorization  = $Session.Authorization 
    })
  }

  return ($payload | ConvertTo-Json | Invoke-RestMethod `
      -Uri "$($Session.BaseUrl)/2.0/repositories/$Workspace/$Repository/branch-restrictions" `
      -Method POST `
      -Headers @{
      "Content-Type" = "application/json"
      Authorization  = $Session.Authorization 
    })
}
