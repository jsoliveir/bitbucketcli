## Instructions

### Installation

Fetch repository:

```powershell
  git clone https://github.com/jsoliveir/BitbucketCloudCLI.git 
  cd BitbucketCloudCLI
```

### Getting Started

Start a bitbucket cloud session:

```powershell
Import-Module .\BitbucketCloud.psm1 -Force

New-BitBucketSession `
    -Username jsoliveir `
    -Password (Read-Host "Password" -AsSecureString)

or

New-BitBucketSession `
    -Username jsoliveir `
    -Password (Read-Host "Password" -AsSecureString) `
    -Server "https://api.bitbucket.org" `
    -Version "2.0"

```

Get Repositories:

```powershell
Get-BitbucketRepositories -Workspace "jsoliveir" | Format-Table
```

## Available functions

_Avaliable functions are available in the Public/ directory in this repository_ 
