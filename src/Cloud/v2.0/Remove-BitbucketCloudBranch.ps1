
Function Remove-BitbucketCloudBranch {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$false)] [String] $Workspace = $Session.Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository,
          [Parameter(Mandatory=$true)] [String] $Name)
    return Invoke-RestMethod `
    -Method Delete `
    -Uri "$($Session.BaseUrl)/2.0/repositories/$Workspace/$Repository/refs/branches/$Name" `
    -Headers @{
        "Content-Type"= "application/json"
        Authorization = $Session.Authorization 
    }
}