
Function Start-BitbucketCloudPipeline{
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$true)] [String] $Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository,
          [Parameter(Mandatory=$true)] [String] $Branch,
          [Parameter(Mandatory=$true)] [String] $Pipeline)

    $request = Invoke-RestMethod `
    -Method POST `
    -Uri "$($Session.Server)/$($Session.Version)/repositories/$Workspace/$Repository/pipelines/" `
    -Headers @{ Authorization = $Session.Authorization} `
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