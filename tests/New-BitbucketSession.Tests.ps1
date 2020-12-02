Describe "New-BitbucketSession" {
  BeforeAll {
    . "$(Split-Path ${PSScriptRoot})\**\New-BitbucketSession.ps1"
    Function Add-BitbucketSession {
      param($Server,$Token,$Password)
      if(!$Token){ $Token = "TokenFromBitbucketCloud" }
      return [PSCustomObject]@{
        Server = "$Server"
        AccessToken = "$Token"
        Authorization = "Bearer $Token"
      }
    }
  }
  Context "Created Session w/ username and password" {
    It "should_be_ok" {
      $session = New-BitbucketSession -Server "test" -Version "1" -Username "test" -Password $("pwd"|ConvertTo-SecureString -AsPlainText -Force)
      $session | Should -Not -BeNullOrEmpty
      $session.Server | Should -Be "test"
      $Session.AccessToken | Should -Not -BeNullOrEmpty
      $Session.Authorization | Should -Not -BeNullOrEmpty
    }
  }
  Context "Created Session w/ username and password and OAuth" {
    It "should_be_ok" {
      $session = New-BitbucketSession -UseOAuth -Server "test" -Version "1" -Username "test" -Password $("pwd"|ConvertTo-SecureString -AsPlainText -Force)
      $session | Should -Not -BeNullOrEmpty
      $session.Server | Should -Be "test"
      $Session.AccessToken | Should -Be "TokenFromBitbucketCloud"
      $Session.Authorization | Should -Not -BeNullOrEmpty
    }
  }
  Context "Created Session w/ token" {
    It "should_be_ok" {
      $session = New-BitbucketSession -Server "test" -Version "1" -Token "1234567689"
      $session | Should -Not -BeNullOrEmpty
      $session.Server | Should -Be "test"
      $Session.AccessToken | Should -Be "1234567689"
      $Session.Authorization | Should -Not -BeNullOrEmpty
      $Session.Authorization | Should -BeLike "Bearer 1234567689"
    }
  }
}