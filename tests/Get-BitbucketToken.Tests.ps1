
Describe "Get-BitbucketToken" {
    BeforeAll {
        . "$(Split-Path ${PSScriptRoot})\**\Get-BitbucketToken.ps1" 
    }
    Context "tokens" {
        It "must_be_base64_encoded" {                     
          $token = Get-BitbucketToken -Username "admin" -Password (`
            "1234" | ConvertTo-SecureString -AsPlainText -Force )
          $credentials = [Text.Encoding]::Utf8.GetString(
              [Convert]::FromBase64String($token))
          $credentials | Should -BeLike "admin:1234"
        }
    }
}
