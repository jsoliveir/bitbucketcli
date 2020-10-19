Function Get-BitbucketBaseUrl {
    $session = (Get-BitbucketSession);
    return "$($session.Server)/$($session.Version)"
}

