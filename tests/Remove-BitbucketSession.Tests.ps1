Describe "Remove-BitbucketSession" {
    BeforeAll {
        . "$(Split-Path ${PSScriptRoot})\**\Remove-BitbucketSession.ps1" 

        $global:BITBUCKETCLI_SESSIONS = @{}
        $global:BITBUCKETCLI_SESSIONS["server"]=([PSCustomObject]@{
            Id     = 1
            Server = "server"
        })
        $global:BITBUCKETCLI_SESSIONS["server2"]=([PSCustomObject]@{
            Id     = 2
            Server = "server2"
        })
    }
    Context "Removed Session By Id" {
        It "should_be_deleted_from_store" {                     
            Remove-BitbucketSession -Id 1
            $global:BITBUCKETCLI_SESSIONS["server2"].Id | Should -BeExactly 2
            $global:BITBUCKETCLI_SESSIONS.Keys | Should -Not -Contain "server"
        }
    }
    Context "Removed Session By Server" {
        It "should_be_deleted_from_store" {                     
            Remove-BitbucketSession -Server "server"
            $global:BITBUCKETCLI_SESSIONS["server2"].Id | Should -BeExactly 2
            $global:BITBUCKETCLI_SESSIONS.Keys | Should -Not -Contain "server"
        }
    }
    Context "Removed All Sessions" {
        It "should_be_deleted_at_all" {                     
            Remove-BitbucketSession 
            @($global:BITBUCKETCLI_SESSIONS.Keys).Count | Should -BeExactly 0
        }
    }
}
