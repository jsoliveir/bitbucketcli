Function Set-BitbucketSession{
    param([Parameter(Mandatory=$false)] [Int] $Id,
          [Parameter(Mandatory=$false)] [String] $Server )

     $global:BITBUCKETCLI_SESSIONS.Values `
        | ForEach-Object { $_.IsSelected = $false } 

    $global:BITBUCKETCLI_SESSIONS.Values `
        | Where-Object { $_.Id -eq $Id -or $_.Server -like $Server  } `
        | Select-Object -Last 1 `
        | ForEach-Object { $_.IsSelected = $true } 
}