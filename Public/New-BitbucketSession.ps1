Function New-BitbucketSession {
    param([Parameter(Mandatory=$false)] [String] $Username,
          [Parameter(Mandatory=$false)] [String] $Password,
          [Parameter(Mandatory=$false)] [String] $Token,
          [Parameter(Mandatory=$false)] [String] $Workspace,
          [Parameter(Mandatory=$false)] [String] $Server = "https://api.bitbucket.org",
          [Parameter(Mandatory=$false)] [String] $Version = "2.0",
          [Parameter(Mandatory=$false)] [Switch] $UseOAuth )

    if(!$Token){
        if(!$Username){
            $Username = (Read-Host "Username for $Server")
        }
        if(!$Password){
            $Password = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto(
                [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR(
                    (Read-Host "Password for $Server" -AsSecureString) ))
        }
    }

    return Add-BitbucketSession `
        -Token $Token `
        -Server   $Server `
        -Username $Username `
        -Password $Password `
        -Workspace $Workspace `
        -Version  $Version `
        -UseOAuth:$UseOAuth
}
