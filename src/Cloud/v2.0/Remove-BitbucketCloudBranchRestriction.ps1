Function Remove-BitbucketCloudBranchRestriction {
  param([Parameter(Mandatory = $false)] [PSCustomObject] $Session = (Get-BitbucketSession),
    [Parameter(Mandatory = $false)] [String] $Workspace = $Session.Workspace,
    [Parameter(Mandatory = $true)]  [String] $Repository,
    [Parameter(Mandatory = $true)]  [String] $Id
  )
  return (Invoke-RestMethod `
      -Uri "$($Session.BaseUrl)/2.0/repositories/$Workspace/$Repository/branch-restrictions/$Id" `
      -Method DELETE `
      -Headers @{
      "Content-Type" = "application/json"
      Authorization  = $Session.Authorization 
    })
}
