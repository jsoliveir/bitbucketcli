<#
    Check the following BITBUCKET API documentation to develop new features:
    https://developer.atlassian.com/bitbucket/api/2/reference/resource/
#>
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

Get-ChildItem -Path $PSScriptRoot\src\ -Filter *.ps1 -Recurse -Verbose:$false  | Foreach-Object {
    . $_.FullName
}

Remove-Item Alias:curl -ErrorAction Ignore -Verbose:$false

Export-ModuleMember -Function * -Verbose:$false

$PSDefaultParameterValues = @{
    "Invoke-RestMethod:TimeoutSec" =  600
}