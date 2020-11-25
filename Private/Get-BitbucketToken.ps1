Function Get-BitbucketToken {
    param([Parameter(Mandatory=$true)] [String] $Username,
          [Parameter(Mandatory=$true)] [SecureString] $Password)
          
    $dPassword = [System.Net.NetworkCredential]::new(`
         [string]::Empty , $Password).Password

    return [Convert]::ToBase64String(
        [Text.Encoding]::ASCII.GetBytes("$Username`:$dPassword"))
}

