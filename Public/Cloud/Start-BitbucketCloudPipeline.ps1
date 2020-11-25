
Function Start-Pipeline{
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] [PSCustomObject] $Repository,
          [Parameter(Mandatory=$true)] [String] $Branch,
          [Parameter(Mandatory=$true)] [String] $Pipeline)

    $request = Invoke-RestMethod `
    -Method POST `
    -Uri "$($Session.Server)/$($Session.Version)/repositories/$($Repository.Workspace)/$($Repository.Name)/pipelines/" `
    -Headers @{ Authorization = "Basic $($Session.AccessToken)"} `
    -ContentType "application/json" `
    -Body "{
      `"target`": {
        `"type`": `"pipeline_ref_target`",
        `"ref_type`": `"branch`",
        `"ref_name`": `"$Branch`",
        `"selector`": {
            `"type`": `"custom`",
            `"pattern`": `"$Pipeline`"
          }
        }
    }"
    return $request
}