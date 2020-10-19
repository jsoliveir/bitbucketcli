Function New-BitbucketSession {
    param([Parameter(Mandatory=$true)] [String] $Username,
    [Parameter(Mandatory=$false)] [SecureString] $Password = (Read-Host "Password" -AsSecureString),
    [Parameter(Mandatory=$false)] [String] $Server = "https://api.bitbucket.org",
    [Parameter(Mandatory=$false)] [String] $Version = "2.0"
    )

    Add-BitbucketSession `
        -Server   $Server `
        -Username $Username `
        -Password $Password `
        -Version $Version

    if(Get-BitbucketUser){
        Write-Information "Info : Loggin succeeded";
    }
}
