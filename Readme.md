# How to use it

### Install the module:
```powershell
Install-Module -Name BitbucketCLI
``` 
### Import the module (locally):

```powershell
  Import-Module .\BitbucketCLI\*.psm1 -Force
```

### Start a session:

If you want to just use bitbucket cloud you just need the following

```powershell
New-BitbucketSession `
    -Password $BITBUCKET_USERNAME `
    -Username $BITBUCKET_PASSWORD `
    -Workspace $BITBUCKET_WORKSPACE 
```

### Bitbucket Cloud OAuth authentication

Use the `-OAuth` argument to fetch a token using the workspace client/secret
https://bitbucket.org/workspace/workspace/settings/api

```powershell
New-BitbucketSession `
    -Password $BITBUCKET_OAUTH_CLIENT_SECRET `
    -Username $BITBUCKET_OAUTH_CLIENT_ID `
    -Workspace $BITBUCKET_WORKSPACE `
    -UseOAuth
```


 (by default the CLI uses bitbucket.org)

```powershell

#create a new session on bitbucket cloud
$SESSION_CLOUD = New-BitbucketSession `
    -Password $BITBUCKET_OAUTH_CLIENT_SECRET `
    -Username $BITBUCKET_OAUTH_CLIENT_ID `
    -Server https://api.bitbucket.org `
    -Workspace $BITBUCKET_WORKSPACE `
    -Version 2.0 `
    -UseOAuth

#create a new session on bitbucket server
$SESSION_ONPREM = New-BitbucketSession `
    -Server https://bitbucket.server.local `
    -Password $BITBUCKET_SERVER_PASSWORD `
    -Username $BITBUCKET_SERVER_USERNAME `
    -Version 1.0 

```

### Use the API:

```powershell
# fetch onprem bitbucket repositories
Get-BitbucketCloudRepositories `
    -Session $SESSION_CLOUD

# fetch onprem bitbucket repositories
Get-BitbucketServerRepositories `
    -Session $SESSION_ONPREM;
```

**if you don't specify any session, by default the CLI will use the last session created**

```powershell

New-BitbucketSession `
    -Password $BITBUCKET_OAUTH_CLIENT_SECRET `
    -Username $BITBUCKET_OAUTH_CLIENT_ID `
    -Workspace $BITBUCKET_WORKSPACE `
    -UseOAuth 


Get-BitbucketCloudRepositories -Verbose
```
### Available functions

>_More functions can be found in the [Public/](Public/) directory in this repository_ 

## Import BitbucketCLI directly from a cloud repository

### Bitbucket Cloud

```powershell
Function Import-BitbucketCLI {
    param([Parameter(Mandatory=$true)] [String] $Username,
          [Parameter(Mandatory=$true)] [String] $Password)

    # remove the directory if exists
    Remove-Item -Force `
        -Recurse BitbucketCLI/ `
        -ErrorAction SilentlyContinue

    # base 64 encoded credential
    $BITBUCKET_BASIC_CREDENTIAL = [Convert]::ToBase64String(
        [Text.Encoding]::ASCII.GetBytes( "${Username}:${Password}"))
        
    # get bitbucket.org pushing credentials
    $BITBUCKET_OAUTH = (Invoke-RestMethod -Method POST `
        "https://bitbucket.org/site/oauth2/access_token" `
        -Body grant_type=client_credentials `
        -Headers @{  Authorization = "Basic ${BITBUCKET_BASIC_CREDENTIAL}" })

    # clone BitbucketCLI repository
    git clone "https://x-token-auth:$($BITBUCKET_OAUTH.access_token)@bitbucket.org/sbanken/BitbucketCLI" BitbucketCLI

    # import module
    Import-Module -Force ./BitbucketCLI/Module.psm1
}

Import-BitbucketCLI `
    -Username $ {BITBUCKET_OAUTH_CLIENT_ID} `
    -Password $ {BITBUCKET_OAUTH_CLIENT_SECRET} 

```


# Mirroring repositories to bitbucket cloud

## Script example:


```powershell

Import-Module -Force .\BitbucketCLI\*.psm1

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
    -Server https://api.bitbucket.org `
    -Workspace $BITBUCKET_WORKSPACE `
    -Version 2.0 `
    -OAuth

#create a new session on bitbucket onprem
$SESSION_ONPREM = New-BitbucketSession `
    -Server https://bitbucket.server.local `
    -Password "bitbucket_app_password" `
    -Username "domain_user" `
    -Version 1.0 

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

