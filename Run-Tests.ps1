Install-Module Pester -Force -SkipPublisherCheck
Import-Module Pester -MinimumVersion 5.0.4 -Force
New-Item -ItemType Directory test-results -Force
Invoke-Pester -OutputFormat  NUnitXml -OutputFile "./test-results/results.xml"