Function Add-BitbucketSession {
    param([Parameter(Mandatory=$true)] [String] $Username,
          [Parameter(Mandatory=$true)] [SecureString] $Password,
          [Parameter(Mandatory=$true)] [String] $Server)
    
    if(!$global:BITBUCKETCLI_SESSIONS){
        $global:BITBUCKETCLI_SESSIONS = @()
    }

    $global:BITBUCKETCLI_SESSIONS `
        | ForEach-Object { $_.Active = $false} 

    $global:BITBUCKETCLI_SESSIONS = 
        @($global:BITBUCKETCLI_SESSIONS `
        | Where-Object { $_.Server -notlike "$Server" })

    $global:BITBUCKETCLI_SESSIONS += ([PSCustomObject] @{
        Active   = $true
        Server   = $Server
        Username = $Username
        Password = ($Password | ConvertFrom-SecureString)
    });
}