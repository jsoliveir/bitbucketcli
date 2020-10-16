Function Get-BitbucketToken {

    $session = (Get-BitbucketSession)

    $password = [Runtime.InteropServices.Marshal]::PtrToStringAuto(
        [Runtime.InteropServices.Marshal]::SecureStringToBSTR(
            ($session.Password | ConvertTo-SecureString)))

    return [Convert]::ToBase64String(
        [Text.Encoding]::ASCII.GetBytes("$($session.Username)`:$password"))
}

