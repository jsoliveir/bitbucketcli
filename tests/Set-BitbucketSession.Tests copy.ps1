
Describe "Set-BitbucketSession" {
    BeforeAll {
        . "..\**\Set-BitbucketSession.ps1" 
        $global:BITBUCKETCLI_SESSIONS = @()
        $global:BITBUCKETCLI_SESSIONS +=([PSCustomObject]@{
            Active = $true
            Server = "server"
        })
        $global:BITBUCKETCLI_SESSIONS += ([PSCustomObject]@{
            Active = $false
            Server = "server2"
        })
        $global:BITBUCKETCLI_SESSIONS += ([PSCustomObject]@{
            Active = $true
            Server = "server3"
        })
    }
    Context "tokens" {
        It "must_keep_only_one_active_session" {                     
            Set-BitbucketSession -Server server
            $activeSessions = @($global:BITBUCKETCLI_SESSIONS | Where Active -eq $true)  
            $inactiveSessions = @($global:BITBUCKETCLI_SESSIONS | Where Active -eq $false)  
            $activeSessions.Count | Should -BeExactly 1
            $inactiveSessions.Count | Should -BeExactly 2
            $activeSessions[0].Server | Should -BeExactly "server"
        }
    }
}
