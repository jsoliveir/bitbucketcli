
Function Get-BitbucketCloudUser {
    param(
        [Parameter(Mandatory=$false)] [PSCustomObject] $Session = (Get-BitbucketSession),
        [Parameter(Mandatory=$false)] [String] $UUID
    )

    if(!$UUID){
        return Invoke-RestMethod `
        -Headers @{Authorization = $Session.Authorization } `
        -Uri "$($Session.BaseUrl)/2.0/user"
    }
    
    try {
     return Invoke-RestMethod `
        -Headers @{Authorization = $Session.Authorization } `
        -Uri "$($Session.BaseUrl)/2.0/users/$UUID"
    }catch{
        return Invoke-RestMethod `
        -Headers @{Authorization = $Session.Authorization } `
        -Uri "$($Session.BaseUrl)/2.0/teams/$UUID"
    }
 
}