Function Add-BitbucketSession {
    param([Parameter(Mandatory=$true)] [String] $Username,
          [Parameter(Mandatory=$true)] [SecureString] $Password,
          [Parameter(Mandatory=$true)] [String] $Server,
          [Parameter(Mandatory=$true)] [String] $Version,
          [Parameter(Mandatory=$false)] [Switch] $OAuth)
    
    $Server = $Server.Trim("/")
    
    if(!$global:BITBUCKETCLI_SESSIONS){
        $global:BITBUCKETCLI_SESSIONS = @()
    }

    $global:BITBUCKETCLI_SESSIONS `
        | ForEach-Object { try { $_.IsSelected = $false } catch { }} 

    $global:BITBUCKETCLI_SESSIONS = 
        @($global:BITBUCKETCLI_SESSIONS `
        | Where-Object { $_.Server -notlike "$Server" })

    if($OAuth){
        $AUTH = "Bearer"
        $ACCESS_TOKEN = (Get-BitbucketOAuthToken  -Username $Username -Password  $Password)
    }else{
        $AUTH = "Basic"
        $ACCESS_TOKEN = (Get-BitbucketBasicToken  -Username $Username -Password  $Password)
    }

    $SESSION = ([PSCustomObject] @{
        Id              = @($global:BITBUCKETCLI_SESSIONS).Count+1
        IsSelected      = $true
        Server          = $Server
        Version         = $Version
        Username        = $Username
        AccessToken     = $ACCESS_TOKEN
        Authorization   = "$AUTH $ACCESS_TOKEN"
    })

    $global:BITBUCKETCLI_SESSIONS += $SESSION
    return $SESSION
}