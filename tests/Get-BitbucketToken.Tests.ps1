
Describe "Get-BitbucketToken" {
    BeforeAll {
        . "..\**\Get-BitbucketToken.ps1" 
        Function Get-BitbucketSession { 
            return @([PSCustomObject]@{
                Username = "admin"
                Password = ("1234" `
                | ConvertTo-SecureString -AsPlainText -Force `
                | ConvertFrom-SecureString )
            })
        }   
    }
    Context "tokens" {
        It "must_be_base64_encoded" {                     
          $token = Get-BitbucketToken
          $credentials = [Text.Encoding]::Utf8.GetString(
              [Convert]::FromBase64String($token))
          $credentials | Should -BeLike "admin:1234"
        }
    }
}
