![Tests](https://github.com/jsoliveir/BitbucketCLI/workflows/Tests/badge.svg)
# How to use it

### Install the module:
```powershell
Install-Module -Name BitbucketCLI
``` 
### Import the module (locally):

```powershell
Import-Module BitbucketCLI
```
### View available commands in BitbucketCLI
```powershell
Get-Command -Module BitbucketCLI 
```

# Available Functions (API):

Take a look at the available functions for:
* [Bitbucket Cloud (v1.0)](src/Cloud/v1.0)
* [Bitbucket Cloud (v2.0)](src/Cloud/v2.0)
* [Bitbucket Server](src/Server)

# Start a session:

If you want to use bitbucket cloud you just need the following

## Bitbucket Cloud 

### Authenticating using the Web Browser 
```powershell
New-BitbucketSession -Workspace "sbanken"
```

### Authenticating using Client Credentials 
```powershell
New-BitbucketSession -Workspace "sbanken" `
    -Password "<ClientSecret>" `
    -Username "<ClientId>" `
    -UseOAuth
```

### Authenticating using Basic Credentials

Create an app password for your account thru the following link:
https://bitbucket.org/account/settings/app-passwords/

Then:

```powershell
New-BitbucketSession -Workspace sbanken `
    -Password "<app-password>" `
    -Username "jsoliveir" `
```

### Authentication using environment variables

> Suggestion: Add the environment variables globally in your OS

> The session creation will become pretty more convenient

```powershell
$env:BITBUCKET_USERNAME = "<username or client id>"
$env:BITBUCKET_PASSWORD = "<password or client secret>"
```

```powershell
New-BitbucketSession -Workspace sbanken
```

## Bitbucket Server

### Authenticating using username and password
```powershell
 New-BitbucketSession -BaseUrl https://bitbucket.server.local `
    -Password $BITBUCKET_SERVER_PASSWORD `
    -Username $BITBUCKET_SERVER_USERNAME
```


## Using multiple Bitucket sessions

```powershell
#create a new session on bitbucket cloud
# (by default the server is bitbucket.org)

$SESSION_CLOUD = New-BitbucketSession `
    -Password $BITBUCKET_OAUTH_CLIENT_SECRET `
    -Username $BITBUCKET_OAUTH_CLIENT_ID `
    -Workspace $BITBUCKET_WORKSPACE 

#create a new session on bitbucket server
$SESSION_ONPREM = New-BitbucketSession `
    -BaseUrl https://bitbucket.server.local `
    -Password $BITBUCKET_SERVER_PASSWORD `
    -Username $BITBUCKET_SERVER_USERNAME

Get-BitbucketCloudRepositories -Session $SESSION_CLOUD

Get-BitbucketCloudRepositories -Session $SESSION_ONPREM

```

# Examples

## Mirroring repositories from bitbucket server to bitbucket cloud:

```powershell

Import-Module -Force .\BitbucketCLI.psm1

$WORKSPACE = "jsoliveir";

#temporary repositories clone path
$REPO_CLONE_PATH = "temp/repositories";

#repositories filter
$REPOSITORY_MATCH_PATTERN ="API/"

#OAuth client Id
$BITBUCKET_OAUTH_CLIENT_ID ="oauth_bitbucket_client_id"

#OAuth client secret
$BITBUCKET_OAUTH_CLIENT_SECRET ="oauth_bitbucket_client_secret"

#create a new session on bitbucket cloud
$SESSION_CLOUD = New-BitbucketSession `
    -Password $BITBUCKET_OAUTH_CLIENT_SECRET `
    -Username $BITBUCKET_OAUTH_CLIENT_ID `
    -BaseUrl https://api.bitbucket.org `
    -Workspace $BITBUCKET_WORKSPACE `

#create a new session on bitbucket onprem
$SESSION_ONPREM = New-BitbucketSession `
    -BaseUrl https://bitbucket.server.local `
    -Password "bitbucket_app_password" `
    -Username "domain_user" 

# fetch onprem bitbucket repositories
$REPOSITORIES_ONPREM = Get-BitbucketServerRepositories `
    -Session $SESSION_ONPREM;

# filter out unwanted repositories
$REPOSITORIES_ONPREM = $REPOSITORIES_ONPREM `
    | Where-Object { "$($_.project.key)/$($_.name)" -imatch $REPOSITORY_MATCH_PATTERN }

Write-Host -ForegroundColor Yellow "The following onprem repositories will be mirrored"
$REPOSITORIES_ONPREM | Select-Object id, @{n="repository";e={"$($_.project.key)/$($_.name)"}} | Format-Table

@($REPOSITORIES_ONPREM ) | ForEach-Object {
    Write-Host -ForegroundColor Magenta "Mirroring $($_.Name)" 

    Remove-BitbucketCloudRepository `
        -Session $SESSION_CLOUD `
        -Name $_.Name `
        -Verbose 

    New-BitbucketCloudRepository `
        -ProjectKey $_.project.key `
        -Session $SESSION_CLOUD `
        -Name $_.Name `
        -Verbose 

    Enable-BitbucketCloudPipelines `
        -Session $SESSION_CLOUD `
        -RepositoryName $_.Name `
        -Verbose

    # mirror onprem repositories tk the cloud
    $REPO_PATH = "$REPO_CLONE_PATH/$($_.Name)"
    git clone "https://user_name:secret@bitbucket.server.local/scm/$($_.project.key)/$($_.name)" $REPO_PATH
    git -C $REPO_PATH push -f --mirror "https://x-token-auth:$($SESSION_CLOUD.AccessToken)@bitbucket.org/${WORKSPACE}/$($_.name).git"
    Remove-Item -Recurse $REPO_PATH -Force
}

```

