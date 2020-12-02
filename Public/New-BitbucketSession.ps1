Function New-BitbucketSession {
    param([Parameter(Mandatory=$false)] [String] $Username,
          [Parameter(Mandatory=$false)] [SecureString] $Password,
          [Parameter(Mandatory=$false)] [String] $Token,
          [Parameter(Mandatory=$false)] [String] $Server = "https://api.bitbucket.org",
          [Parameter(Mandatory=$false)] [String] $Version = "2.0",
          [Parameter(Mandatory=$false)] [Switch] $UseOAuth )

    if(!$Token){
        if(!$Username){
            $Username = (Read-Host "Username for $Server")
        }
        if(!$Password){
            $Password = (Read-Host "Password for $Server" -AsSecureString)
        }
    }

    return Add-BitbucketSession `
        -Token $Token `
        -Server   $Server `
        -Username $Username `
        -Password $Password `
        -Version  $Version `
        -UseOAuth:$UseOAuth
}
