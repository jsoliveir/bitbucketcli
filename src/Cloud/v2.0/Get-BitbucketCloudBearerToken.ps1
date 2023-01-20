
Function Get-BitbucketCloudBearerToken {
    param(
        [Parameter(Mandatory=$false)] [String] $Username,
        [Parameter(Mandatory=$false)] [String] $Password
    )

    if(!$Username){
        $Username = Read-Host "Username (Client Id)"
    }
    if(!$Password){
        $Password = Read-Host "Password (Client Secret)"
    }
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

