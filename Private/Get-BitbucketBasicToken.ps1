Function Get-BitbucketBasicToken {
    param([Parameter(Mandatory=$true)] [String] $Username,
          [Parameter(Mandatory=$true)] [SecureString] $Password)
         
    #decrypt secure string
    $CREDENTIAL = [System.Net.NetworkCredential]::new(`
        [string]::Empty , $Password)

    return "${Username}:$($CREDENTIAL.Password)" `
        | ConvertTo-CBase64 -Encoding ([System.Text.Encoding]::UTF8)
}

