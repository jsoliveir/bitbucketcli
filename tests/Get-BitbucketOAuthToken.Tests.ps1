Describe "Get-BitbucketSession" {
    BeforeAll {
        . "$(Split-Path ${PSScriptRoot})\**\Get-BitbucketOAuthToken.ps1"
        Function Get-BitbucketCloudOAuthToken{
            return "TokenFromBitbucketCloud"
        }
    }
    Context "Bitbucket Cloud OAuth Tokens" {
        It "must_be_fetched" {
            $token = Get-BitbucketOAuthToken -Username "username" -Password ("password")
            $token | Should -Be "TokenFromBitbucketCloud"
        }
    }

    Context "Bitbucket Cloud OAuth Tokens using empty Token" {
        It "must_be_fetched" {
            $token = Get-BitbucketOAuthToken -Token "" -Username "username" -Password ("password")
            $token | Should -Be "TokenFromBitbucketCloud"
        }
    }
    Context "Bitbucket Server OAuth Token" {
        It "must_be_fetched" {
            $token = Get-BitbucketOAuthToken -Token "TokenFromBitbucketServer"
            $token | Should -Be "TokenFromBitbucketServer"
        }
    }
}