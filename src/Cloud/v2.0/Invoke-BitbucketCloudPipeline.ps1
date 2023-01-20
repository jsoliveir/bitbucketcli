Function Invoke-BitbucketCloudPipeline {
    param(
        [Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
        [Parameter(Mandatory=$false)] [String] $Workspace = $Session.Workspace,
        [Parameter(Mandatory=$true)] [String] $Repository,
        [Parameter(Mandatory=$false)] [String] $Pipeline,
        [Parameter(Mandatory=$false)] [String] $Commit,
        [Parameter(Mandatory=$false)] [String] 
            [ValidateSet ('custom','pull-request','branch')] $Trigger='branch',
        [Parameter(Mandatory=$false)] [String] $Branch = "master",
        [Parameter(Mandatory=$false)] [HashTable] $Arguments = @{}
        )

    $payload = [PSCustomObject]@{
        target = @{
            type="pipeline_ref_target"
            ref_type="branch"
            ref_name=$Branch
            selector=@{}
            commit=@{}
        }
        variables=($Arguments.Keys |% {
            @{ 
                key=$_; 
                value=$Arguments[$_]
                secured=$false
            }
        })
    }
    if ($Commit){
       $payload.target.commit=@{
            hash="$Commit"
            type="commit"
        }
    }

    if($Trigger -in ('custom','pull-request')){
        $payload.target.selector=@{
            type=$Trigger.ToLower()
            pattern=$Pipeline
        }
    }

    if($VerbosePreference){
        Write-Host "Trigger: $Trigger"
        $payload |ConvertTo-Json
    }
    
    return ($payload |ConvertTo-Json| Invoke-RestMethod `
        -Method POST `
        -Uri "$($Session.BaseUrl)/2.0/repositories/${Workspace}/${Repository}/pipelines/" `
        -Headers @{ Authorization = $Session.Authorization} `
        -ContentType "application/json")
}