Function Get-BitbucketCloudOAuthToken {
    param([Parameter(Mandatory=$true)] [String] $Username,
          [Parameter(Mandatory=$true)] [String] $Password)
    
    #base 64 encodend credential
    $BITBUCKET_BASIC_CREDENTIAL = [Convert]::ToBase64String(
        [Text.Encoding]::ASCII.GetBytes( "${Username}:${Password}"))

    #get bitbucket.org pushing credentials
    $BITBUCKET_OAUTH = (Invoke-RestMethod -Method POST `
        "https://bitbucket.org/site/oauth2/access_token" `
        -Body grant_type=client_credentials `
        -Headers @{  Authorization = "Basic ${BITBUCKET_BASIC_CREDENTIAL}" })

    return $BITBUCKET_OAUTH.access_token;
}

