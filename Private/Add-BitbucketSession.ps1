Function Add-BitbucketSession {
    param([Parameter(Mandatory=$false)] [String] $Username,
          [Parameter(Mandatory=$false)] [SecureString] $Password,
          [Parameter(Mandatory=$false)] [String] $Token,
          [Parameter(Mandatory=$true)]  [String] $Server,
          [Parameter(Mandatory=$true)]  [String] $Version,
          [Parameter(Mandatory=$false)] [Switch] $UseOAuth)

    $Server = $Server.Trim("/")
    
    if(!$global:BITBUCKETCLI_SESSIONS){
        $global:BITBUCKETCLI_SESSIONS = @()
    }

    $global:BITBUCKETCLI_SESSIONS `
        | ForEach-Object { try { $_.IsSelected = $false } catch { }} 

    $global:BITBUCKETCLI_SESSIONS = 
        @($global:BITBUCKETCLI_SESSIONS `
        | Where-Object { $_.Server -notlike "$Server" })
        
    if(!$Token -and !$UseOAuth){
        $ACCESS_TOKEN = (Get-BitbucketBasicToken  -Username $Username -Password  $Password)
    }else{
        $ACCESS_TOKEN = (Get-BitbucketOAuthToken -Token $Token -Username $Username -Password $Password)
    }

    $SESSION = ([PSCustomObject] @{
        Id              = @($global:BITBUCKETCLI_SESSIONS).Count+1
        IsSelected      = $true
        Server          = $Server
        Version         = $Version
        Username        = $Username
        AccessToken     = $ACCESS_TOKEN
        Authorization   = "$Schema $ACCESS_TOKEN"
    })

    $global:BITBUCKETCLI_SESSIONS += $SESSION
    return $SESSION
}