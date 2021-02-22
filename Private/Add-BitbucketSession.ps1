Function Add-BitbucketSession {
    param([Parameter(Mandatory=$false)] [String] $Username,
          [Parameter(Mandatory=$false)] [String] $Password,
          [Parameter(Mandatory=$false)] [String] $Workspace,
          [Parameter(Mandatory=$false)] [String] $Token,
          [Parameter(Mandatory=$true)]  [String] $Server,
          [Parameter(Mandatory=$true)]  [String] $Version,
          [Parameter(Mandatory=$false)] [Switch] $UseOAuth)

    $Server = $Server.Trim("/")
    
    if(!$global:BITBUCKETCLI_SESSIONS){
        $global:BITBUCKETCLI_SESSIONS = @{}
    }

    if(!$Token -and !$UseOAuth){
        $ACCESS_TOKEN = (Get-BitbucketBasicToken  -Username $Username -Password  $Password)
        $AUTH_SCHEMA = "Basic"
    }else{
        $ACCESS_TOKEN = (Get-BitbucketOAuthToken -Token $Token -Username $Username -Password $Password)
        $AUTH_SCHEMA = "Bearer"
    }
    
    $unique_key = "${Server}:${Workspace}"

    $global:BITBUCKETCLI_SESSIONS[$unique_key] = ([PSCustomObject] @{
        Id              = [guid]::newguid() 
        Server          = $Server
        Workspace       = $Workspace
        Version         = $Version
        Username        = $Username
        AccessToken     = $ACCESS_TOKEN
        Authorization   = "$AUTH_SCHEMA $ACCESS_TOKEN"
    })

    return $global:BITBUCKETCLI_SESSIONS[$unique_key]
}