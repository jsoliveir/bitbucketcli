<#
    Check the following BITBUCKET API documentation to develop new features:
    https://developer.atlassian.com/bitbucket/api/2/reference/resource/
#>

$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\ -Filter *.ps1 -Recurse -ErrorAction SilentlyContinue -Verbose:$false )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue -Verbose:$false )

$Public | Sort-Object -Property Basename | Foreach-Object{
    . $_.FullName
}
$Private | Sort-Object -Property Basename | Foreach-Object{
    . $_.FullName
}

Remove-Item Alias:curl -ErrorAction Ignore -Verbose:$false

Export-ModuleMember -Function $Public.Basename -Verbose:$false