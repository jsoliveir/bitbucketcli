## Instructions

### Installation

Fetch repository:

```powershell
  git clone https://github.com/jsoliveir/BitbucketCLI.git 
  Import-Module .\BitbucketCLI\Module.psm1 -Force
```

### Getting Started

Start a bitbucket cloud session:

```powershell
Import-Module .\BitbucketCloud.psm1 -Force

New-BitbucketSession `
    -Username jsoliveir `
    -Password (Read-Host "Password" -AsSecureString)

or

New-BitbucketSession `
    -Username jsoliveir `
    -Password (Read-Host "Password" -AsSecureString) `
    -Server "https://api.bitbucket.org" `
    -Version "2.0"

```

Get Repositories:

```powershell
Get-BitbucketCloudRepositories -Workspace "jsoliveir" | Format-Table
Get-BitbucketServerRepositories -Project "API" | Format-Table
```

## Available functions

_Avaliable functions are available in the Public/ directory in this repository_ 
