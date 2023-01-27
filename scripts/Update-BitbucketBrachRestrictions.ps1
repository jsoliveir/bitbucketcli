#!/usr/bin/env pwsh
param (
  [Parameter(Mandatory)] [Regex] $Repository,
  [Parameter(Mandatory)] [Regex] $Branch,
  [Parameter()] [string[]] $Groups
)
$ErrorActionPreference = "Stop"

Import-Module -Force "$PSScriptRoot/../BitbucketCLI.psm1"

New-BitbucketSession -Workspace sbanken `
  -Password $env:BITBUCKET_OAUTH_CLIENT_SECRET `
  -Username $env:BITBUCKET_OAUTH_CLIENT_ID `
| Out-Null

Write-Host "Enumerating the repositories list ..."
Get-BitbucketCloudRepositories `
| Where-Object name -Match $Repository.ToString() `
| ForEach-Object {
  Write-Warning "Applying branch restriction on $($_.name) ..."
  New-BitbucketCloudBranchRestriction `
    -AllowedGroups $Groups `
    -Repository $_.name `
    -Branch $Branch
}