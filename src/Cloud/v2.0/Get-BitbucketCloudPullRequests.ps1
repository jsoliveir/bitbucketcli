Function Get-BitbucketCloudPullRequests {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$false)] [String] $Workspace = $Session.Workspace,
          [Parameter(Mandatory=$true)] $Repository,
          [Parameter(Mandatory=$false)] $Page=1,
          [Parameter(Mandatory=$false)] $Query,
          [Parameter(Mandatory=$false)] $PageLen=50,
          [Parameter(Mandatory=$false)] $Branch="master",
          [Parameter(Mandatory=$false)] [Switch]$All
          )
    
    return (Invoke-RestMethod `
        -Method GET `
        -Uri "$($Session.BaseUrl)/2.0/repositories/$Workspace/$Repository/pullrequests/?q=${Query}&page=${Page}&pagelen=${PageLen}" `
        -Headers @{
            "Content-Type"= "application/json"
            Authorization = $Session.Authorization 
        }).values
}
