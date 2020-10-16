Function Set-BitbucketCredentials{
    param([Parameter(Mandatory=$true)] [String] $Username,
          [Parameter(Mandatory=$true)] [SecureString] $Password)
    $env:BITBUCKET_USERNAME = $Username 
    $env:BITBUCKET_PASSWORD =  $Password | ConvertFrom-SecureString
}