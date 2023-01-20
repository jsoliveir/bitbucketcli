Install-Module Pester -Force -SkipPublisherCheck -Scope CurrentUser

Import-Module Pester -MinimumVersion 5.0.4 -Force

Import-Module ./BitbucketCLI.psm1 -Force

New-Item -ItemType Directory test-results -Force

Invoke-Pester -OutputFormat  JUnitXml -OutputFile "./test-results/results.xml"