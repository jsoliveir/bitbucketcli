Function Remove-BitbucketSession{
    param([Parameter(Mandatory=$true)] [String] $Id)

    $global:BITBUCKETCLI_SESSIONS =  $env:BITBUCKETCLI_SESSIONS `
    | Where-Object { $_.Id -notlike "$Id" }
 
}