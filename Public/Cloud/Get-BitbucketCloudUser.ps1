
Function Get-BitbucketCloudUser {
    param(
        [Parameter(Mandatory=$false)] [PSCustomObject] $Session = (Get-BitbucketSession),
        [Parameter(Mandatory=$false)] [String] $UUID
    )

    if(!$UUID){
        return Invoke-RestMethod `
        -Headers @{Authorization = $Session.Authorization } `
        -Uri "$($Session.Server)/$($Session.Version)/user"
    }
    
    try {
     return Invoke-RestMethod `
        -Headers @{Authorization = $Session.Authorization } `
        -Uri "$($Session.Server)/$($Session.Version)/users/$UUID"
    }catch{
        return Invoke-RestMethod `
        -Headers @{Authorization = $Session.Authorization } `
        -Uri "$($Session.Server)/$($Session.Version)/teams/$UUID"
    }
 
}