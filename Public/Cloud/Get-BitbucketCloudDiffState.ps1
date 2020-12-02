

Function Get-BitbucketCloudDiffState{
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] [String] $Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository,
          [Parameter(Mandatory=$true)] [String] $FromCommit,
          [Parameter(Mandatory=$true)] [String] $ToCommit
          )
    return (Invoke-RestMethod `
        -Method GET `
        -Uri "$($Session.Server)/$($Session.Version)/repositories/$Workspace/$Repository/diffstat/$FromCommit..$ToCommit" `
        -Headers @{ Authorization = $Session.Authorization}).values
}