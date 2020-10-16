
Function Get-BitbucketUser {
    return Invoke-RestMethod `
    -Headers @{Authorization = "Basic $(Get-BitbucketToken)" } `
    -Uri "$(Get-BitbucketApi)/2.0/user"
}