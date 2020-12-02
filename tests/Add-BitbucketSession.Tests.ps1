Describe "Add-BitbucketSession" {
  BeforeAll {
    . "$(Split-Path ${PSScriptRoot})\**\Get-BitbucketBasicToken.ps1"
    . "$(Split-Path ${PSScriptRoot})\**\Add-BitbucketSession.ps1"
    
    Function Get-BitbucketOAuthToken(){
        return "OAuthToken"
    }
  }
  BeforeEach{
      Remove-Variable -Scope Global BITBUCKETCLI_SESSIONS -ErrorAction Ignore
  }
  Context "environment_variables" {
    It "must_be_set" {
      Add-BitbucketSession -Server "test" -Version "1" -Username "test" -Password $("pwd"|ConvertTo-SecureString -AsPlainText -Force)
        @($global:BITBUCKETCLI_SESSIONS).Count | Should -BeExactly 1 
    }
    It "must_be_valid" {
      Add-BitbucketSession -Server "test" -Version "1" -Username "test" -Password $("pwd"|ConvertTo-SecureString -AsPlainText -Force)
      $global:BITBUCKETCLI_SESSIONS["test"].Id | Should -Not -Be $Null 
      $global:BITBUCKETCLI_SESSIONS["test"].IsSelected | Should -Be $true 
      $global:BITBUCKETCLI_SESSIONS["test"].Username | Should -Be "test" 
      $global:BITBUCKETCLI_SESSIONS["test"].AccessToken | Should -BeOfType [String]
    }
    It "must_create_a_session_id" {
      $global:BITBUCKETCLI_SESSIONS=@{}
      $global:BITBUCKETCLI_SESSIONS["server1"]=([PSCustomObject]@{
          IsSelected = $false
      });
      Add-BitbucketSession -Server "test" -Version "1" -Username "test" -Password $("pwd"|ConvertTo-SecureString -AsPlainText -Force)
      $global:BITBUCKETCLI_SESSIONS.Keys.Count | Should -BeExactly 2 
    }
  }
  Context "Added Sessions" {
    It "must_be_only_one_IsSelected" {
      Add-BitbucketSession -Server "test" -Version "1" -Username "test" -Password $("pwd"|ConvertTo-SecureString -AsPlainText -Force)
      Add-BitbucketSession -Server "test2" -Version "1" -Username "test2" -Password $("pwd"|ConvertTo-SecureString -AsPlainText -Force)
      @($global:BITBUCKETCLI_SESSIONS.Keys).Count | Should -BeExactly 2
      @($global:BITBUCKETCLI_SESSIONS.Values | Where-Object IsSelected -eq $true).Count | Should -BeExactly 1 
    }
  }
  Context "Sessions passwords" {
    It "must_be_secured_string" {
      Add-BitbucketSession -Server "test" -Version "1" -Username "test" -Password $("pwd"|ConvertTo-SecureString -AsPlainText -Force)
      $global:BITBUCKETCLI_SESSIONS["test"].AccessToken | Should -Not -BeNullOrEmpty
    }
  }
  Context "Session Created" {
    It "should_return_the_session" {
      $session = Add-BitbucketSession -Server "test" -Version "1" -Username "test" -Password $("pwd"|ConvertTo-SecureString -AsPlainText -Force)
      $session | Should -Not -BeNullOrEmpty
      $session.Server | Should -Be "test"
      $Session.Authorization | Should -Not -BeNullOrEmpty
    }
  }
  Context "Session w/ username and password" {
    It "should_be_ok" {
      $session = Add-BitbucketSession -Server "test" -Version "1" -Username "test" -Password $("pwd"|ConvertTo-SecureString -AsPlainText -Force)
      $session | Should -Not -BeNullOrEmpty
      $session.Server | Should -Be "test"
      $Session.Authorization | Should -Not -BeNullOrEmpty
    }
  }
  Context "Session w/ username and password and OAuth" {
    It "should_be_invoke_request_oauth_token" {
      $session = Add-BitbucketSession -UseOAuth -Server "test" -Version "1" -Username "test" -Password $("pwd"|ConvertTo-SecureString -AsPlainText -Force)
      $session | Should -Not -BeNullOrEmpty
      $session.Server | Should -Be "test"
      $Session.Authorization | Should -Not -BeNullOrEmpty
      $Session.AccessToken | Should -Be "OAuthToken"
    }
  }
}