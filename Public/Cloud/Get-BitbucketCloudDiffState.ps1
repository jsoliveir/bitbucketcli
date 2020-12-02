

Function Get-BitbucketCloudDiffState{
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] [String] $Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository,
          [Parameter(Mandatory=$true)] [String] $From,
          [Parameter(Mandatory=$true)] [String] $To
          )
    return (Invoke-RestMethod `
        -Method GET `
        -Uri "$($Session.Server)/$($Session.Version)/repositories/$Workspace/$Repository/diffstat/$From..$To" `
        -Headers @{ Authorization = $Session.Authorization}).values
}