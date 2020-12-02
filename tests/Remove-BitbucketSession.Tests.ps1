Describe "Remove-BitbucketSession" {
    BeforeAll {
        . "$(Split-Path ${PSScriptRoot})\**\Remove-BitbucketSession.ps1" 
        $global:BITBUCKETCLI_SESSIONS = @()
        $global:BITBUCKETCLI_SESSIONS +=([PSCustomObject]@{
            Id     = 1
            IsSelected = $true
            Server = "server"
        })
        $global:BITBUCKETCLI_SESSIONS +=([PSCustomObject]@{
            Id     = 2
            IsSelected = $true
            Server = "server2"
        })
    }
    Context "tokens" {
        It "must_remove_a_session" {                     
            Remove-BitbucketSession -Id 1
            @($global:BITBUCKETCLI_SESSIONS).Count | Should -BeExactly 1
            $global:BITBUCKETCLI_SESSIONS[0].Id | Should -BeExactly 2
        }
    }
}
