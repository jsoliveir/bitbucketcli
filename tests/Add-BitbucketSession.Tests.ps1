Describe "Add-BitbucketSession" {
  BeforeAll {
    . "$PSScriptRoot\..\src\Add-BitbucketSession.ps1"
  }
  BeforeEach {
    Remove-Variable -Scope Global BITBUCKETCLI_SESSIONS -ErrorAction Ignore
  }
  Context "environment_variables" {
    It "must_be_set" {
      Add-BitbucketSession -BaseUrl "test" -Token "1234"
      @($global:BITBUCKETCLI_SESSIONS).Count | Should -BeExactly 1 
    }
    It "must_be_valid" {
      $session = Add-BitbucketSession -BaseUrl "test" -Token "1234" -Workspace "workspace1"
      $session.Id | Should -Not -Be $Null 
      $session.Workspace | Should -Not -Be $Null 
      $session.AccessToken | Should -Be "1234" 
      $session.Authorization | Should -BeOfType [String]
    }
    It "must_create_a_session_id" {
      $global:BITBUCKETCLI_SESSIONS = @{}
      $global:BITBUCKETCLI_SESSIONS[(New-Guid)] = ([PSCustomObject]@{
          IsSelected = $false
        });
      Add-BitbucketSession -BaseUrl "test" -Token "1234"
      $global:BITBUCKETCLI_SESSIONS.Keys.Count | Should -BeExactly 2 
    }
  }
  Context "Added Sessions" {
    It "must_be_only_one" {
      Add-BitbucketSession -BaseUrl "test1" -Token "1234"
      Add-BitbucketSession -BaseUrl "test" -Token "1234"
      Add-BitbucketSession -BaseUrl "test" -Token "1234"
      @($global:BITBUCKETCLI_SESSIONS.Keys).Count | Should -BeExactly 2
      @($global:BITBUCKETCLI_SESSIONS.Values | Where-Object BaseUrl -like "test").Count | Should -BeExactly 1 
    }
  }
  Context "Sessions passwords" {
    It "must_be_secured_string" {
      $session = Add-BitbucketSession -BaseUrl "test" -Token "1234"
      $session.AccessToken | Should -Not -BeNullOrEmpty
    }
  }
  Context "Session Created" {
    It "should_return_the_session" {
      $session = Add-BitbucketSession -BaseUrl "test" -Token "1234"
      $session | Should -Not -BeNullOrEmpty
      $Session.BaseUrl | Should -Be "test"
      $Session.Authorization | Should -Not -BeNullOrEmpty
    }
  }
  Context "Session w/ username and password" {
    It "should_be_ok" {
      $session = Add-BitbucketSession -BaseUrl "test" -Token "1234"
      $session | Should -Not -BeNullOrEmpty
      $Session.BaseUrl | Should -Be "test"
      $Session.Authorization | Should -Not -BeNullOrEmpty
    }
  }
}