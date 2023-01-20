Function Remove-BitbucketSession{
    param(
        [Parameter(Mandatory=$false)] [Int] $Id,
        [Parameter(Mandatory=$false)] [String] $BaseUrl )

    if($Id -or $BaseUrl){
        @($global:BITBUCKETCLI_SESSIONS.Keys) `
        | Where-Object {  
            $global:BITBUCKETCLI_SESSIONS[$_].Id -eq $Id `
                -or $global:BITBUCKETCLI_SESSIONS[$_].BaseUrl -eq $BaseUrl } `
        | ForEach-Object { $global:BITBUCKETCLI_SESSIONS.Remove($_) }
    }else{
        $global:BITBUCKETCLI_SESSIONS = @{}
    }
    
   
}