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
```

Get Repositories:

```powershell
Get-BitbucketRepositories -Workspace "jsoliveir" | Format-Table
```