Function Set-BitbucketSession{
    param([Parameter(Mandatory=$true)] [String] $Id)

     $global:BITBUCKETCLI_SESSIONS `
        | ForEach-Object { $_.IsSelected = $false } 

    $global:BITBUCKETCLI_SESSIONS `
        | Where-Object { $_.Id -eq $Id } `
        | Select-Object -Last 1 `
        | ForEach-Object { $_.IsSelected = $true } 
}