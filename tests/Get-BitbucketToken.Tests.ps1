
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
          #  Get-BitbucketToken | ConvertFrom-CBase64 | Should -Contain "admin"
        }
    }
}