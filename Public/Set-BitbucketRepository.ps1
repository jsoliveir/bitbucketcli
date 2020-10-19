
Function Set-BitbucketRepository {
    param(
          [Parameter(Mandatory=$true)] [String] $Workspace,
          [Parameter(Mandatory=$true)] [String] $Name,
          [Parameter(Mandatory=$true)] [String] $ProjectKey)
    return Invoke-RestMethod `
    -Method PUT `
    -Uri "$(Get-BitbucketBaseUrl)/repositories/$Workspace/$Name" `
    -Body "{ `"is_private`":true, `"project`": { `"key`":`"$ProjectKey`"} }" `
    -Headers @{
        "Content-Type"= "application/json"
        Authorization = "Basic $(Get-BitbucketToken)" 
    }
}