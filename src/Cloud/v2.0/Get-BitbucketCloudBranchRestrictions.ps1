Function Get-BitbucketCloudBranchRestrictions {
  param([Parameter(Mandatory = $false)] [PSCustomObject] $Session = (Get-BitbucketSession),
    [Parameter(Mandatory = $false)] [String] $Workspace = $Session.Workspace,
    [Parameter(Mandatory = $true)]  [String] $Repository
  )
  return (
    Invoke-RestMethod -Uri "$($Session.BaseUrl)/2.0/repositories/$Workspace/$Repository/branch-restrictions" `
      -Headers @{ 
      "Content-Type" = "application/json"; 
      Authorization  = $Session.Authorization  
    }).values
}
