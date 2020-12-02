Function Get-BitbucketOAuthToken {
    param([Parameter(Mandatory=$false)] [String] $Username,
          [Parameter(Mandatory=$false)] [String] $Password,
          [Parameter(Mandatory=$false)] [String] $Token)
    if(!$Token){
        $Token = (Get-BitbucketCloudOAuthToken $Username $Password)
    }
    return  $Token;
}

