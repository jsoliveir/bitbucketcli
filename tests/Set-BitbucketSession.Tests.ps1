
Describe "Set-BitbucketSession" {
    BeforeAll {
        . "$(Split-Path ${PSScriptRoot})\**\Set-BitbucketSession.ps1" 
        $global:BITBUCKETCLI_SESSIONS = @()
        $global:BITBUCKETCLI_SESSIONS +=([PSCustomObject]@{
            Id = 1
            IsSelected = $true
            Server = "server"
        })
        $global:BITBUCKETCLI_SESSIONS += ([PSCustomObject]@{
            Id = 2
            IsSelected = $false
            Server = "server2"
        })
        $global:BITBUCKETCLI_SESSIONS += ([PSCustomObject]@{
            Id = 3
            IsSelected = $true
            Server = "server3"
        })
    }
    Context "tokens" {
        It "must_keep_only_one_IsSelected_session" {                     
            Set-BitbucketSession -Id 1
            $IsSelectedSessions = @($global:BITBUCKETCLI_SESSIONS | Where IsSelected -eq $true)  
            $inIsSelectedSessions = @($global:BITBUCKETCLI_SESSIONS | Where IsSelected -eq $false)  
            $IsSelectedSessions.Count | Should -BeExactly 1
            $inIsSelectedSessions.Count | Should -BeExactly 2
            $IsSelectedSessions[0].Server | Should -BeExactly "server"
        }
    }
}
