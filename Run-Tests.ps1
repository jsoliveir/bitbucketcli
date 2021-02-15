Install-Module Pester -Force -SkipPublisherCheck

Import-Module Pester -MinimumVersion 5.0.4 -Force

Import-Module  *.psd1 -Force

New-Item -ItemType Directory test-results -Force

Invoke-Pester -OutputFormat  JUnitXml -OutputFile "./test-results/results.xml"