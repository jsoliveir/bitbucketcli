Function Remove-BitbucketSession{
    param([Parameter(Mandatory=$true)] [String] $Id)

    $global:BITBUCKETCLI_SESSIONS =  $global:BITBUCKETCLI_SESSIONS `
    | Where-Object { $_.Id -ne $Id }
 
}