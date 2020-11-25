Function Add-BitbucketSession {
    param([Parameter(Mandatory=$true)] [String] $Username,
          [Parameter(Mandatory=$true)] [SecureString] $Password,
          [Parameter(Mandatory=$true)] [String] $Server,
          [Parameter(Mandatory=$true)] [String] $Version,
          [Parameter(Mandatory=$false)] [ValidateSet("Cloud","Server")] $Provider = 'Cloud')
    
    $Server = $Server.Trim("/")
    
    if(!$global:BITBUCKETCLI_SESSIONS){
        $global:BITBUCKETCLI_SESSIONS = @()
    }

    $global:BITBUCKETCLI_SESSIONS `
        | ForEach-Object { $_.Active = $false} 

    $global:BITBUCKETCLI_SESSIONS = 
        @($global:BITBUCKETCLI_SESSIONS `
        | Where-Object { $_.Server -notlike "$Server" })

  
    $global:BITBUCKETCLI_SESSIONS += ([PSCustomObject] @{
        Id          = @($global:BITBUCKETCLI_SESSIONS).Count+1
        Active      = $true
        Server      = $Server
        Version     = $Version
        Provider    = $Provider
        Username    = $Username
        AccessToken =  (Get-BitbucketToken `
            -Username $Username `
            -Password  $Password)
    });
}