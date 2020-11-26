Function Get-BitbucketOAuthToken {
    param([Parameter(Mandatory=$true)] [String] $Username,
          [Parameter(Mandatory=$true)] [SecureString] $Password)
    
    #decrypt secure string
    $CREDENTIAL = [System.Net.NetworkCredential]::new(`
        [string]::Empty , $Password)
    
    #base 64 encodend credential
    $BITBUCKET_BASIC_CREDENTIAL = "${Username}:$($CREDENTIAL.Password)" `
    | ConvertTo-CBase64 -Encoding ([System.Text.Encoding]::UTF8)

    #get bitbucket.org pushing credentials
    $BITBUCKET_OAUTH = (Invoke-RestMethod -Method POST `
        "https://bitbucket.org/site/oauth2/access_token" `
        -Body grant_type=client_credentials `
        -Headers @{  Authorization = "Basic ${BITBUCKET_BASIC_CREDENTIAL}" })

    return $BITBUCKET_OAUTH.access_token;
}

