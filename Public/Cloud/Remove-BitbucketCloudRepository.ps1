Function Remove-BitbucketCloudRepository {
    param([Parameter(Mandatory=$false)] [PSCustomObject] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$false)] [String] $Workspace = $Session.Workspace,
          [Parameter(Mandatory=$true)] [String] $Name)
    
    return Invoke-RestMethod `
        -Method DELETE `
        -Uri "$($Session.Server)/$($Session.Version)/repositories/$Workspace/$Name" `
        -Headers @{
            "Content-Type"= "application/json"
            Authorization = $Session.Authorization }
}
