Function Get-BitbucketCloudCommits{
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$false)] [String] $Workspace = $Session.Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository,
          [Parameter(Mandatory=$false)] [String] $Revision,
          [Parameter(Mandatory=$false)] [int] $Limit = 1000 )

    return (Invoke-RestMethod `
        -Headers @{Authorization = $Session.Authorization } `
        -Uri "$($Session.Server)/$($Session.Version)/repositories/${Workspace}/${Repository}/commits/${Revision}?limit=$Limit").values
          
}