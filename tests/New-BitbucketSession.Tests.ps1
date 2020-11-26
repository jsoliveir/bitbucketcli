Describe "New-BitbucketSession" {
  BeforeAll {
    . "$(Split-Path ${PSScriptRoot})\**\New-BitbucketSession.ps1"
    Function Add-BitbucketSession {
      return [PSCustomObject]@{
        Server = "test"
        AccessToken = "OK"
        Authorization = "OK"
      }
    }
  }
  Context "Created Session" {
    It "should_be_returned" {
      $session = New-BitbucketSession -Server "test" -Version "1" -Username "test" -Password $("pwd"|ConvertTo-SecureString -AsPlainText -Force)
      $session | Should -Not -BeNullOrEmpty
      $session.Server | Should -Be "test"
      $Session.AccessToken | Should -Not -BeNullOrEmpty
      $Session.Authorization | Should -Not -BeNullOrEmpty
    }
  }
}