Function Get-BitbucketCloudBranches{
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] [String] $Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository,
          [Parameter(Mandatory=$false)] $Query,
          [Parameter(Mandatory=$false)] $Page=1,
          [Parameter(Mandatory=$false)] $PageLen=50)
    
    return (Invoke-RestMethod `
        -Method GET `
        -Uri "$($Session.Server)/$($Session.Version)/repositories/$Workspace/$Repository/refs/branches/?q=${Query}&page=$Page&pagelen=$PageLen" `
        -Headers @{ Authorization = $Session.Authorization}).Values
}