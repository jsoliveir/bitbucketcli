Function New-BitbucketSession {
    param([Parameter(Mandatory=$true)] [String] $Username,
          [Parameter(Mandatory=$false)] [SecureString] $Password `
            = (Read-Host "Password" -AsSecureString))

    Set-BitbucketCredentials `
        -Username $Username `
        -Password $Password

    if(Get-BitbucketUser){
        Write-Information "Info : Loggin succeeded";
    }
}
