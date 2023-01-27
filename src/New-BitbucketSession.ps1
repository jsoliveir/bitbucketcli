Function New-BitbucketSession {
  param(
    [Parameter(Mandatory = $false)] [String] $Username = $env:BITBUCKET_USERNAME,
    [Parameter(Mandatory = $false)] [String] $Password = $env:BITBUCKET_PASSWORD,
    [Parameter(Mandatory = $false)] [String] $BaseUrl = "https://api.bitbucket.org",
    [Parameter(Mandatory = $false)] [String] $Workspace,
    [Parameter(Mandatory = $false)] [Switch] $Force

  )

  switch -regex ($BaseUrl) {
    # Bitbucket Server Authentication
    default {
      $Token = Get-BitbucketServerBasicToken
    }
    # Bitbucket Cloud Authentication
    "bitbucket.org" { 
      if (!$Workspace) {
        $Workspace = (Read-Host "Bitbucket Cloud Workspace")
      }
  
      if ($Username -and $Password) {
        $Token = Get-BitbucketCloudBearerToken `
          -Username $Username `
          -Password $Password 
      }
      else {
        $Token = Request-BitbucketCloudUserToken `
          -ClientId "UYgYdfUPhHB6aJwvg4" `
          -Force:$Force
      }
    }
  }

  $Session = Add-BitbucketSession `
    -Workspace $Workspace `
    -BaseUrl  $BaseUrl `
    -Token $Token 

  return $Session
}
