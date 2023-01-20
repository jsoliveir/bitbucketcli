Describe "Get-BitbucketSession" {
    BeforeAll {
        . "$PSScriptRoot\..\src\Cloud\**\Get-BitbucketCloudBearerToken.ps1"
        Function Get-BitbucketCloudBearerToken{
            return "TokenFromBitbucketCloud"
        }
    }
    Context "Bitbucket Cloud OAuth Tokens" {
        It "must_be_fetched" {
            $token = Get-BitbucketCloudBearerToken -Username "username" -Password ("password")
            $token | Should -Be "TokenFromBitbucketCloud"
        }
    }

    Context "Bitbucket Cloud OAuth Tokens using empty Token" {
        It "must_be_fetched" {
            $token = Get-BitbucketCloudBearerToken -Username "username" -Password ("password")
            $token | Should -Be "TokenFromBitbucketCloud"
        }
    }
}