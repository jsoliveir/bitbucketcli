
Function Get-BitbucketUser {
    return Invoke-RestMethod `
    -Headers @{Authorization = "Basic $(Get-BitbucketToken)" } `
    -Uri "$(Get-BitbucketBaseUrl)/user"
}