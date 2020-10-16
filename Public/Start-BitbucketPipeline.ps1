
Function Start-Pipeline{
    param([Parameter(Mandatory=$true)] [PSCustomObject] $Repository,
          [Parameter(Mandatory=$true)] [String] $Branch,
          [Parameter(Mandatory=$true)] [String] $Pipeline)

    $request = Invoke-RestMethod `
    -Method POST `
    -Uri "$(Get-BitbucketApi)/2.0/repositories/$($Repository.Workspace)/$($Repository.Name)/pipelines/" `
    -Headers @{ Authorization = "Basic $(Get-BitbucketToken)"} `
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