Function New-BitbucketSession {
    param([Parameter(Mandatory=$false)] [String] $Username = (Read-Host "Username for $Server"),
    [Parameter(Mandatory=$false)] [SecureString] $Password = (Read-Host "Password for $Server" -AsSecureString),
    [Parameter(Mandatory=$false)] [String] $Server = "https://api.bitbucket.org",
    [Parameter(Mandatory=$false)] [String] $Version = "2.0",
    [Parameter(Mandatory=$false)] [Switch] $OAuth
    )

    return Add-BitbucketSession `
        -Server   $Server `
        -Username $Username `
        -Password $Password `
        -Version $Version `
        -OAuth:$OAuth
}
