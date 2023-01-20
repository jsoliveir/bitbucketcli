Function New-BitbucketSession {
    param(
        [Parameter(Mandatory = $false)] [String] $Username = $env:BITBUCKET_USERNAME,
        [Parameter(Mandatory = $false)] [String] $Password = $env:BITBUCKET_PASSWORD,
        [Parameter(Mandatory = $false)] [String] $BaseUrl = "https://api.bitbucket.org",
        [Parameter(Mandatory = $false)] [String] $Workspace,
        [Parameter(Mandatory = $false)] [Switch] $UseOAuth, 
        [Parameter(Mandatory = $false)] [String] $Token
    )

    if(!$Workspace -and $BaseUrl -match "bitbucket.org"){
        $Workspace = (Read-Host "Bitbucket Cloud Workspace")
    }

    if (!$Token -and $UseOAuth) {
        if (!$Username) {
            $Username = (Read-Host "Username (Client Id) for $BaseUrl")
        }
        if (!$Password) {
            $Password = (Read-Host "Password (Client Secret) for $BaseUrl" -AsSecureString)
        }
        if ($UseOAuth) {
            $Token = Get-BitbucketCloudBearerToken `
                -Username $Username `
                -Password $Password
        }
    }
    elseif (!$Token) {
       $Token = Request-BitbucketCloudUserToken `
            -ClientId "UYgYdfUPhHB6aJwvg4"
    }

    return Add-BitbucketSession `
        -Workspace $Workspace `
        -BaseUrl  $BaseUrl `
        -Token $Token `
        | Select-Object BaseUrl, AccessToken

}
