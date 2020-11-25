
Describe "Set-BitbucketSession" {
    BeforeAll {
        . "$(Split-Path ${PSScriptRoot})\**\Set-BitbucketSession.ps1" 
        $global:BITBUCKETCLI_SESSIONS = @()
        $global:BITBUCKETCLI_SESSIONS +=([PSCustomObject]@{
            Id = 1
            Active = $true
            Server = "server"
        })
        $global:BITBUCKETCLI_SESSIONS += ([PSCustomObject]@{
            Id = 2
            Active = $false
            Server = "server2"
        })
        $global:BITBUCKETCLI_SESSIONS += ([PSCustomObject]@{
            Id = 3
            Active = $true
            Server = "server3"
        })
    }
    Context "tokens" {
        It "must_keep_only_one_active_session" {                     
            Set-BitbucketSession -Id 1
            $activeSessions = @($global:BITBUCKETCLI_SESSIONS | Where Active -eq $true)  
            $inactiveSessions = @($global:BITBUCKETCLI_SESSIONS | Where Active -eq $false)  
            $activeSessions.Count | Should -BeExactly 1
            $inactiveSessions.Count | Should -BeExactly 2
            $activeSessions[0].Server | Should -BeExactly "server"
        }
    }
}
