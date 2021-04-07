Function Update-BitbucketServerRepositoryProject {
    param(
        [Parameter(Mandatory=$false)] [PSCustomObject] $Session = (Get-BitbucketSession),
        [Parameter(Mandatory=$true)] [String] $Project,
        [Parameter(Mandatory=$true)] [String] $Repository,
		[Parameter(Mandatory=$true)] [String] $NewProject
    )
    
	#Write-output "$($Session.Server)/rest/api/1.0/projects/${Project}/repos/${Repository}"
	
    Invoke-RestMethod `
        -Method PUT `
        -Uri "$($Session.Server)/rest/api/1.0/projects/${Project}/repos/${Repository}" `
        -Headers @{
            "Content-Type"= "application/json"
            Authorization = $Session.Authorization 
        }`
		-Body "{ `"name`": `"$Repository`", `"project`": {`"key`": `"$NewProject`"}}" `
    | Out-Null
}
