
Describe "Get-BitbucketBasicToken" {
    BeforeAll {
        . "$(Split-Path ${PSScriptRoot})\src\Server\Get-BitbucketServerBasicToken.ps1" 
    }
    Context "tokens" {
        It "must_be_base64_encoded" {                     
          $token = Get-BitbucketServerBasicToken -Username "admin" -Password ("1234")
          $credentials = [Text.Encoding]::Utf8.GetString(
              [Convert]::FromBase64String($token))
          $credentials | Should -BeLike "admin:1234"
        }
    }
}
