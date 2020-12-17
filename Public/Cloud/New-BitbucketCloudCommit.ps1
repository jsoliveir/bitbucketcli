Function New-BitbucketCloudCommit{
    param([Parameter(Mandatory=$false)] [PSCustomObject] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)]  [String]    $Workspace,
          [Parameter(Mandatory=$true)]  [String]    $Repository,
          [Parameter(Mandatory=$false)] [String[]]  $FilesToDelete, 
          [Parameter(Mandatory=$false)] [String[]]  $FilesToAdd,
          [Parameter(Mandatory=$false)] [String]    $Message,
          [Parameter(Mandatory=$false)] [String]    $Branch)
          
    return  (Invoke-RestMethod `
         -Method POST `
         -Uri "$($Session.Server)/$($Session.Version)/repositories/$Workspace/$Repository/src/" `
         -Headers @{ 
             Authorization = $Session.Authorization
             ContentType ='application/x-www-form-urlencode'
            } `
         -Body @{
            message = $Message
            branch = $Branch
         })
}