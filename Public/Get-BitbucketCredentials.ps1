Function Get-BitbucketCredentials {
    $password = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
        [Runtime.InteropServices.Marshal]::SecureStringToBSTR(
            ($env:BITBUCKET_PASSWORD | ConvertTo-SecureString)))

    return [Convert]::ToBase64String(
        [Text.Encoding]::ASCII.GetBytes("$env:BITBUCKET_USERNAME`:$password"))
}

