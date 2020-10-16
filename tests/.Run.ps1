Install-Module Pester -Force -SkipPublisherCheck -Verbose
Import-Module Pester -MinimumVersion 5.0.4 -Force

Invoke-Pester -ScriptPath $PSScriptRoot