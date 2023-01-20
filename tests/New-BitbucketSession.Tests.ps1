Describe "New-BitbucketSession" {
  BeforeAll {
    . "${PSScriptRoot})\..\src\New-BitbucketSession.ps1"
    Function Add-BitbucketSession {
      param($BaseUrl,$Token,$Password)
      if(!$Token){ $Token = "TokenFromBitbucketCloud" }
      return [PSCustomObject]@{
        BaseUrl = "$BaseUrl"
        AccessToken = "$Token"
        Authorization = "Bearer $Token"
      }
    }
  }
  Context "Created Session w/ username and password" {
    It "should_be_ok" {
      $session = New-BitbucketSession -BaseUrl "test" -Version "1" -Username "test" -Password $("pwd")
      $session | Should -Not -BeNullOrEmpty
      $Session.BaseUrl | Should -Be "test"
      $Session.AccessToken | Should -Not -BeNullOrEmpty
      $Session.Authorization | Should -Not -BeNullOrEmpty
    }
  }
  Context "Created Session w/ username and password and OAuth" {
    It "should_be_ok" {
      $session = New-BitbucketSession -BaseUrl "test" -Version "1" -Username "test" -Password $("pwd")
      $session | Should -Not -BeNullOrEmpty
      $Session.BaseUrl | Should -Be "test"
      $Session.AccessToken | Should -Be "TokenFromBitbucketCloud"
      $Session.Authorization | Should -Not -BeNullOrEmpty
    }
  }
  Context "Created Session w/ token" {
    It "should_be_ok" {
      $session = New-BitbucketSession -BaseUrl "test" -Version "1" -Token "1234567689"
      $session | Should -Not -BeNullOrEmpty
      $Session.BaseUrl | Should -Be "test"
      $Session.AccessToken | Should -Be "1234567689"
      $Session.Authorization | Should -Not -BeNullOrEmpty
      $Session.Authorization | Should -BeLike "Bearer 1234567689"
    }
  }
}