Function Remove-BitbucketSession{
    param([Parameter(Mandatory=$true)]  [String] $Username,
          [Parameter(Mandatory=$true)]  [SecureString] $Password,
          [Parameter(Mandatory=$false)] [String] $Server = "https://api.bitbucket.org")

    $global:BITBUCKETCLI_SESSIONS =  $env:BITBUCKETCLI_SESSIONS `
    | Where-Object { $_.Server -notlike "$Server" }
 
}