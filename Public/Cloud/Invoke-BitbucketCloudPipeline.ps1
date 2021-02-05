Function Invoke-BitbucketCloudPipeline {
    param(
        [Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
        [Parameter(Mandatory=$true)] [String] $Workspace,
        [Parameter(Mandatory=$true)] [String] $Repository,
        [Parameter(Mandatory=$false)] [String] $Pipeline,
        [Parameter(Mandatory=$false)] [String] $Commit,
        [Parameter(Mandatory=$false)] [String] 
            [ValidateSet ('custom','pull-request','branch')] $Type='branch',
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

    if($Type -notlike "branch"){
        $payload.target.selector=@{
            type=$Type.ToLower()
            pattern=$Pipeline
        }
    }
    
    return ($payload |ConvertTo-Json| Invoke-RestMethod `
        -Method POST `
        -Uri "$($Session.Server)/$($Session.Version)/repositories/${Workspace}/${Repository}/pipelines/" `
        -Headers @{ Authorization = $Session.Authorization} `
        -ContentType "application/json")
}