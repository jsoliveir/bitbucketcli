Function New-BitbucketSession {
  param(
    [Parameter(Mandatory = $false)] [String] $Username = $env:BITBUCKET_USERNAME,
    [Parameter(Mandatory = $false)] [String] $Password = $env:BITBUCKET_PASSWORD,
    [Parameter(Mandatory = $false)] [String] $BaseUrl = "https://api.bitbucket.org",
    [Parameter(Mandatory = $false)] [String] $Workspace
  )

  # Bitbucket Server Authentication
  if ($BaseUrl -notmatch "bitbucket.org") {
    $Token = Get-BitbucketServerBasicToken
  }

  # Bitbucket Cloud Authentication
  if ($BaseUrl -match "bitbucket.org") {
    if (!$Workspace) {
      $Workspace = (Read-Host "Bitbucket Cloud Workspace")
    }

    if($Username -or $Password){
      $Token = Get-BitbucketCloudBearerToken `
        -Username $Username `
        -Password $Password 
    }

    $Token = Request-BitbucketCloudUserToken `
      -ClientId "UYgYdfUPhHB6aJwvg4"
  }


  return Add-BitbucketSession `
    -Workspace $Workspace `
    -BaseUrl  $BaseUrl `
    -Token $Token `
  | Select-Object BaseUrl, AccessToken
}
