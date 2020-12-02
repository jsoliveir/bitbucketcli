Function Remove-BitbucketSession{
    param(
        [Parameter(Mandatory=$false)] [Int] $Id,
        [Parameter(Mandatory=$false)] [String] $Server)

    if($Server){
        $global:BITBUCKETCLI_SESSIONS.Remove($Server)
    }elseif($Id){
      @($global:BITBUCKETCLI_SESSIONS.Keys) `
            | Where-Object {  $global:BITBUCKETCLI_SESSIONS[$_].Id -ne $Id } `
            | ForEach-Object { $global:BITBUCKETCLI_SESSIONS.Remove($_) }
    }else{
        Remove-Variable -Scope Global BITBUCKETCLI_SESSIONS -ErrorAction Ignore
    }
}