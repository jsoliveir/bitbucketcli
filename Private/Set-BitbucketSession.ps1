Function Set-BitbucketSession{
    param([Parameter(Mandatory=$true)] [String] $Server)

     $global:BITBUCKETCLI_SESSIONS `
    | ForEach-Object { $_.Active = $false } `
    | Where-Object { $_.Server -like "*$Server*" } `
    | ForEach-Object { $_.Active = $true } `
    | Select-Object -Last 1

}