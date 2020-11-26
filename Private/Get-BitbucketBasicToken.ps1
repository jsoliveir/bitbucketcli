Function Get-BitbucketBasicToken {
    param([Parameter(Mandatory=$true)] [String] $Username,
          [Parameter(Mandatory=$true)] [SecureString] $Password)
         
    #decrypt secure string
    $dPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto(
        [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Password))

    return [Convert]::ToBase64String(
        [Text.Encoding]::ASCII.GetBytes("${Username}:${dPassword}"))
}

