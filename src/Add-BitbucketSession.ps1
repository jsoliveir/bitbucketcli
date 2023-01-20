Function Add-BitbucketSession {
    param(
        [Parameter(Mandatory=$false)] [ValidateSet('Basic','Bearer')] $TokenType = 'Bearer',
        [Parameter(Mandatory=$false)]  [String] $Workspace = "default",
        [Parameter(Mandatory=$true)]  [String] $BaseUrl,
        [Parameter(Mandatory=$false)] [String] $Token
    )

    $BaseUrl = $BaseUrl.Trim("/")
    
    if(!$global:BITBUCKETCLI_SESSIONS){
        $global:BITBUCKETCLI_SESSIONS = @{}
    }

    $unique_key = "${BaseUrl}:${Workspace}"

    $global:BITBUCKETCLI_SESSIONS[$unique_key] = ([PSCustomObject] @{
        Id              = [guid]::newguid() 
        Workspace       = $Workspace
        BaseUrl         = $BaseUrl
        AccessToken     = $Token
        Authorization   = "$TokenType $Token"
    })

    return $global:BITBUCKETCLI_SESSIONS[$unique_key]
}