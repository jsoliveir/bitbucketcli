Function Get-BitbucketCommits{
    param([Parameter(Mandatory=$true)] [String] $Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository,
          [Parameter(Mandatory=$false)] [String] $Branch = "master")

          return Invoke-RestMethod `
          -Headers @{Authorization = "Basic $(Get-BitbucketToken)" } `
          -Uri "$(Get-BitbucketBaseUrl)/repositories/${Workspace}/${Repository}/commits/${Branch}"
          
}