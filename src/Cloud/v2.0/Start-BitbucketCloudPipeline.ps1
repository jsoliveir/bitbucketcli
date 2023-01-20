
Function Start-BitbucketCloudPipeline{
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
          [Parameter(Mandatory=$false)] [String] $Workspace = $Session.Workspace,
          [Parameter(Mandatory=$true)] [String] $Repository,
          [Parameter(Mandatory=$true)] [String] $Branch,
          [Parameter(Mandatory=$true)] [String] $Pipeline)

    $request = Invoke-RestMethod `
    -Method POST `
    -Uri "$($Session.BaseUrl)/2.0/repositories/$Workspace/$Repository/pipelines/" `
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