Function Remove-BitbucketSession{
    param(
        [Parameter(Mandatory=$false)] [Int] $Id,
        [Parameter(Mandatory=$false)] [String] $Server)

    if($Server){
        $global:BITBUCKETCLI_SESSIONS.Remove($Server)
    }elseif($Id -and $Id -gt 0){
      @($global:BITBUCKETCLI_SESSIONS.Keys) `
            | Where-Object {  $global:BITBUCKETCLI_SESSIONS[$_].Id -eq $Id } `
            | ForEach-Object { $global:BITBUCKETCLI_SESSIONS.Remove($_) }
    }else{
        $global:BITBUCKETCLI_SESSIONS=@{}
    }
}