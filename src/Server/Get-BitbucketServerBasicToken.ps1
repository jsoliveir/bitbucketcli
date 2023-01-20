Function Get-BitbucketServerBasicToken {
    param([Parameter(Mandatory=$true)] [String] $Username,
          [Parameter(Mandatory=$true)] [String] $Password)
         

    return [Convert]::ToBase64String(
        [Text.Encoding]::ASCII.GetBytes("${Username}:${Password}"))
}

