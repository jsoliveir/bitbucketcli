Function Get-BitbucketOAuthToken {
    param([Parameter(Mandatory=$true)] [String] $Username,
          [Parameter(Mandatory=$true)] [SecureString] $Password)
    
    #decrypt secure string
    $dPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto(
        [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Password))
    
    #base 64 encodend credential
    $BITBUCKET_BASIC_CREDENTIAL = [Convert]::ToBase64String(
        [Text.Encoding]::ASCII.GetBytes( "${Username}:${dPassword}"))

    #get bitbucket.org pushing credentials
    $BITBUCKET_OAUTH = (Invoke-RestMethod -Method POST `
        "https://bitbucket.org/site/oauth2/access_token" `
        -Body grant_type=client_credentials `
        -Headers @{  Authorization = "Basic ${BITBUCKET_BASIC_CREDENTIAL}" })

    return $BITBUCKET_OAUTH.access_token;
}

