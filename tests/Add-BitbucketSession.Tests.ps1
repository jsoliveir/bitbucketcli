Describe "Add-BitbucketSession" {
  BeforeAll {
    . "$(Split-Path ${PSScriptRoot})\**\Get-BitbucketBasicToken.ps1"
    . "$(Split-Path ${PSScriptRoot})\**\Get-BitbucketOAuthToken.ps1"
    . "$(Split-Path ${PSScriptRoot})\**\Add-BitbucketSession.ps1"
    Function Get-BitbucketCloudOAuthToken(){
        return "OAuthToken"
    }
  }
  BeforeEach{
      Remove-Variable -Scope Global BITBUCKETCLI_SESSIONS -ErrorAction Ignore
  }
  Context "environment_variables" {
    It "must_be_set" {
      Add-BitbucketSession -Server "test" -Version "1" -Username "test" -Password $("pwd")
        @($global:BITBUCKETCLI_SESSIONS).Count | Should -BeExactly 1 
    }
    It "must_be_valid" {
      $session = Add-BitbucketSession -Server "test" -Version "1" -Username "test" -Password $("pwd") -Workspace "workspace1"
      $session.Id | Should -Not -Be $Null 
      $session.Workspace | Should -Not -Be $Null 
      $session.Username | Should -Be "test" 
      $session.AccessToken | Should -BeOfType [String]
    }
    It "must_create_a_session_id" {
      $global:BITBUCKETCLI_SESSIONS=@{}
      $global:BITBUCKETCLI_SESSIONS[(New-Guid)]=([PSCustomObject]@{
          IsSelected = $false
      });
      Add-BitbucketSession -Server "test" -Version "1" -Username "test" -Password $("pwd")
      $global:BITBUCKETCLI_SESSIONS.Keys.Count | Should -BeExactly 2 
    }
  }
  Context "Added Sessions" {
    It "must_be_only_one" {
      Add-BitbucketSession -Server "test1" -Version "1" -Username "test" -Password $("pwd")
      Add-BitbucketSession -Server "test" -Version "1" -Username "test" -Password $("pwd")
      Add-BitbucketSession -Server "test" -Version "1" -Username "test2" -Password $("pwd")
      @($global:BITBUCKETCLI_SESSIONS.Keys).Count | Should -BeExactly 2
      @($global:BITBUCKETCLI_SESSIONS.Values | Where-Object Server -like "test").Count | Should -BeExactly 1 
    }
  }
  Context "Sessions passwords" {
    It "must_be_secured_string" {
      $session=Add-BitbucketSession -Server "test" -Version "1" -Username "test" -Password $("pwd")
      $session.AccessToken | Should -Not -BeNullOrEmpty
    }
  }
  Context "Session Created" {
    It "should_return_the_session" {
      $session = Add-BitbucketSession -Server "test" -Version "1" -Username "test" -Password $("pwd")
      $session | Should -Not -BeNullOrEmpty
      $session.Server | Should -Be "test"
      $Session.Authorization | Should -Not -BeNullOrEmpty
    }
  }
  Context "Session w/ username and password" {
    It "should_be_ok" {
      $session = Add-BitbucketSession -Server "test" -Version "1" -Username "test" -Password $("pwd")
      $session | Should -Not -BeNullOrEmpty
      $session.Server | Should -Be "test"
      $Session.Authorization | Should -Not -BeNullOrEmpty
    }
  }
  Context "Session w/ username and password and OAuth" {
    It "should_be_invoke_request_oauth_token" {
      $session = Add-BitbucketSession -UseOAuth -Server "test" -Version "1" -Username "test" -Password $("pwd")
      $session | Should -Not -BeNullOrEmpty
      $session.Server | Should -Be "test"
      $Session.AccessToken | Should -BeLike "OAuthToken"
      $Session.Authorization | Should -BeLike "Bearer OAuthToken"
    }
  }
}