Describe "Add-BitbucketSession" {
  BeforeAll {
    . "..\**\Add-BitbucketSession.ps1"
  }
  Context "environment_variables" {
    It "must_be_set" {
      Remove-Variable -Scope Global BITBUCKETCLI_SESSIONS -ErrorAction Ignore
      Add-BitbucketSession -Server "test" -Username "test" -Password $("pwd"|ConvertTo-SecureString -AsPlainText -Force)
        @($global:BITBUCKETCLI_SESSIONS).Count | Should -BeExactly 1 
      }
    It "must_be_valid" {
      Remove-Variable -Scope Global BITBUCKETCLI_SESSIONS -ErrorAction Ignore
      Add-BitbucketSession -Server "test" -Username "test" -Password $("pwd"|ConvertTo-SecureString -AsPlainText -Force)
      $global:BITBUCKETCLI_SESSIONS[0].Active | Should -Be $true 
      $global:BITBUCKETCLI_SESSIONS[0].Username | Should -Be "test" 
      $global:BITBUCKETCLI_SESSIONS[0].Password | Should -BeOfType [String]
    }
  }
  Context "sessions" {
    It "must_be_only_one_active" {
      Remove-Variable -Scope Global BITBUCKETCLI_SESSIONS -ErrorAction Ignore
      Add-BitbucketSession -Server "test" -Username "test" -Password $("pwd"|ConvertTo-SecureString -AsPlainText -Force)
      Add-BitbucketSession -Server "test2" -Username "test2" -Password $("pwd"|ConvertTo-SecureString -AsPlainText -Force)
      @($global:BITBUCKETCLI_SESSIONS).Count | Should -BeExactly 2
      @($global:BITBUCKETCLI_SESSIONS | Where Active -eq $true).Count | Should -BeExactly 1 
    }
  }
  Context "passwords" {
    It "must_be_secured_string" {
      Remove-Variable -Scope Global BITBUCKETCLI_SESSIONS -ErrorAction Ignore
      Add-BitbucketSession -Server "test" -Username "test" -Password $("pwd"|ConvertTo-SecureString -AsPlainText -Force)
      {ConvertTo-SecureString $global:BITBUCKETCLI_SESSIONS[0].Password} | Should -Not -Throw 
      {ConvertTo-SecureString $global:BITBUCKETCLI_SESSIONS[0].Password} | Should -Not -BeNullOrEmpty
    }
  }
}