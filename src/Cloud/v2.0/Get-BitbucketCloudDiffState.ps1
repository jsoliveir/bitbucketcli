

Function Get-BitbucketCloudDiffState{
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$false)] [String] $Workspace = $Session.Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository,
          [Parameter(Mandatory=$true)] [String] $From,
          [Parameter(Mandatory=$true)] [String] $To
          )
    return (Invoke-RestMethod `
        -Method GET `
        -Uri "$($Session.BaseUrl)/2.0/repositories/$Workspace/$Repository/diffstat/$From..$To" `
        -Headers @{ Authorization = $Session.Authorization}).values
}