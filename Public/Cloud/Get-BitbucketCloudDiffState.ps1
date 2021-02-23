

Function Get-BitbucketCloudDiffState{
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$false)] [String] $Workspace = $Session.Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository,
          [Parameter(Mandatory=$true)] [String] $From,
          [Parameter(Mandatory=$true)] [String] $To
          )
    return (Invoke-RestMethod `
        -Method GET `
        -Uri "$($Session.Server)/$($Session.Version)/repositories/$Workspace/$Repository/diffstat/$To..$From" `
        -Headers @{ Authorization = $Session.Authorization}).values
}