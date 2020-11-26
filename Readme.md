# How to use it

### Import the module:

```powershell
  Import-Module .\BitbucketCLI\Module.psm1 -Force
```

### Start a session:

```powershell

#create a new session on bitbucket cloud
$SESSION_CLOUD = New-BitbucketSession `
    -Password ($BITBUCKET_OAUTH_CLIENT_SECRET | ConvertTo-SecureString -AsPlainText -Force) `
    -Username $BITBUCKET_OAUTH_CLIENT_ID `
    -Server https://api.bitbucket.org `
    -Version 2.0 `
    -OAuth

#create a new session on bitbucket server
$SESSION_ONPREM = New-BitbucketSession `
    -Password ("password"| ConvertTo-SecureString  -AsPlainText -Force) `
    -Server https://git.internbank.no `
    -Username "user_name" `
    -Version 1.0 

```

### Use the API:

```powershell
# fetch onprem bitbucket repositories
Get-BitbucketCloudRepositories `
    -Session $SESSION_CLOUD
    -Workspace jsoliveir

# fetch onprem bitbucket repositories
Get-BitbucketServerRepositories `
    -Session $SESSION_ONPREM;
```

### Available functions

>_More functions can be found in the Public/ directory in this repository_ 

# Mirroring repositories to bitbucket cloud

## Script example:

```powershell

Import-Module -Force .\BitbucketCLI\Module.psm1

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
    -Password ($BITBUCKET_OAUTH_CLIENT_SECRET | ConvertTo-SecureString -AsPlainText -Force) `
    -Username $BITBUCKET_OAUTH_CLIENT_ID `
    -Server https://api.bitbucket.org `
    -Version 2.0 `
    -OAuth

#create a new session on bitbucket onprem
$SESSION_ONPREM = New-BitbucketSession `
    -Password ("password"| ConvertTo-SecureString  -AsPlainText -Force) `
    -Server https://git.internbank.no `
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
        -Workspace sbanken `
        -Verbose 

    New-BitbucketCloudRepository `
        -ProjectKey $_.project.key `
        -Session $SESSION_CLOUD `
        -Name $_.Name `
        -Workspace sbanken `
        -Verbose 

    Enable-BitbucketCloudPipelines `
        -Session $SESSION_CLOUD `
        -RepositoryName $_.Name `
        -Workspace sbanken `
        -Verbose

    # mirror onprem repositories tk the cloud
    $REPO_PATH = "$REPO_CLONE_PATH/$($_.Name)"
    git clone "https://git.internbank.no/scm/$($_.project.key)/$($_.name)" $REPO_PATH
    git -C $REPO_PATH push -f --mirror "https://x-token-auth:$($SESSION_CLOUD.AccessToken)@bitbucket.org/sbanken/$($_.name).git"
    Remove-Item -Recurse $REPO_PATH -Force
}

```

