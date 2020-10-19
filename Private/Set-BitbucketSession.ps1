Function Set-BitbucketSession{
    param([Parameter(Mandatory=$true)] [String] $Server)

     $global:BITBUCKETCLI_SESSIONS `
        | ForEach-Object { $_.Active = $false } 

    $global:BITBUCKETCLI_SESSIONS `
        | Where-Object { $_.Server -like "$Server" } `
        | Select-Object -Last 1 `
        | ForEach-Object { $_.Active = $true } 
}