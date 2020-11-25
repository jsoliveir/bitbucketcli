Describe "Add-BitbucketSession" {
  BeforeAll {
    . "$(Split-Path ${PSScriptRoot})\**\Get-BitbucketToken.ps1"
    . "$(Split-Path ${PSScriptRoot})\**\Add-BitbucketSession.ps1"
  }
  Context "environment_variables" {
    It "must_be_set" {
      Remove-Variable -Scope Global BITBUCKETCLI_SESSIONS -ErrorAction Ignore
      Add-BitbucketSession -Server "test" -Version "1" -Username "test" -Password $("pwd"|ConvertTo-SecureString -AsPlainText -Force)
        @($global:BITBUCKETCLI_SESSIONS).Count | Should -BeExactly 1 
    }
    It "must_be_valid" {
      Remove-Variable -Scope Global BITBUCKETCLI_SESSIONS -ErrorAction Ignore
      Add-BitbucketSession -Server "test" -Version "1" -Username "test" -Password $("pwd"|ConvertTo-SecureString -AsPlainText -Force)
      $global:BITBUCKETCLI_SESSIONS[0].Id | Should -Not -Be $Null 
      $global:BITBUCKETCLI_SESSIONS[0].Active | Should -Be $true 
      $global:BITBUCKETCLI_SESSIONS[0].Username | Should -Be "test" 
      $global:BITBUCKETCLI_SESSIONS[0].AccessToken | Should -BeOfType [String]
    }
    It "must_create_a_session_id" {
      $global:BITBUCKETCLI_SESSIONS = @();
      $global:BITBUCKETCLI_SESSIONS +=([PSCustomObject]@{
          Active = $false
      });
      Add-BitbucketSession -Server "test" -Version "1" -Username "test" -Password $("pwd"|ConvertTo-SecureString -AsPlainText -Force)
      $global:BITBUCKETCLI_SESSIONS[1].Id | Should -BeExactly 2 
    }
  }
  Context "sessions" {
    It "must_be_only_one_active" {
      Remove-Variable -Scope Global BITBUCKETCLI_SESSIONS -ErrorAction Ignore
      Add-BitbucketSession -Server "test" -Version "1" -Username "test" -Password $("pwd"|ConvertTo-SecureString -AsPlainText -Force)
      Add-BitbucketSession -Server "test2" -Version "1" -Username "test2" -Password $("pwd"|ConvertTo-SecureString -AsPlainText -Force)
      @($global:BITBUCKETCLI_SESSIONS).Count | Should -BeExactly 2
      @($global:BITBUCKETCLI_SESSIONS | Where-Object Active -eq $true).Count | Should -BeExactly 1 
    }
  }
  Context "passwords" {
    It "must_be_secured_string" {
      Remove-Variable -Scope Global BITBUCKETCLI_SESSIONS -ErrorAction Ignore
      Add-BitbucketSession -Server "test" -Version "1" -Username "test" -Password $("pwd"|ConvertTo-SecureString -AsPlainText -Force)
      $global:BITBUCKETCLI_SESSIONS[0].AccessToken | Should -Not -BeNullOrEmpty
    }
  }
}