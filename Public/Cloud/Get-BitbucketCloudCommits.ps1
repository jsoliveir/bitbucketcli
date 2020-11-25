Function Get-BitbucketCloudCommits{
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] [String] $Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository,
          [Parameter(Mandatory=$false)] [String] $Branch = "master")

    return Invoke-RestMethod `
        -Headers @{Authorization = "Basic $($Session.AccessToken)" } `
        -Uri "$($Session.Server)/$($Session.Version)/repositories/${Workspace}/${Repository}/commits/${Branch}"
          
}