Function New-BitbucketSession {
    param([Parameter(Mandatory=$true)] [String] $Username,
    [Parameter(Mandatory=$false)] [SecureString] $Password = (Read-Host "Password" -AsSecureString),
    [Parameter(Mandatory=$false)] [String] $Server = "https://api.bitbucket.org")

    Add-BitbucketSession `
        -Server   $Server `
        -Username $Username `
        -Password $Password

    if(Get-BitbucketUser){
        Write-Information "Info : Loggin succeeded";
    }
}
