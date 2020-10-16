Function Get-BitbucketApi{
    if($env:BITBUCKET_API){
        return $env:BITBUCKET_API
    }
    return "https://api.bitbucket.org"
}
