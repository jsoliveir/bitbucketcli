<#
    Check the following BITBUCKET API documentation to develop new features:
    https://developer.atlassian.com/bitbucket/api/2/reference/resource/
#>

$Public =  @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$Private =  @( Get-ChildItem -Path $PSScriptRoot\PRivate\*.ps1 -ErrorAction SilentlyContinue )

Write-Host -ForegroundColor cyan "Importing Bitbucket CLI ..."
$Public | Sort-Object -Property Basename | Foreach-Object{
    Write-Host -ForegroundColor Magenta "* $($_.Basename)"
    . $_.FullName
}
$Private | Sort-Object -Property Basename | Foreach-Object{
    . $_.FullName
}

Remove-Item Alias:curl -ErrorAction Ignore

Export-ModuleMember -Function $Public.Basename