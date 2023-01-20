Function Remove-BitbucketCloudRepositoryVariable {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$false)] [String] $Workspace = $Session.Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository,
          [Parameter(Mandatory=$false)] [String] $Id
          )
   
    return Invoke-RestMethod `
    -Method Delete `
    -Uri "$($Session.BaseUrl)/2.0/repositories/$Workspace/$Repository/pipelines_config/variables/$Id" `
    -Headers @{
        "Content-Type"= "application/json"
        Authorization = $Session.Authorization 
    }
}

