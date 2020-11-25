Function Get-BitbucketServerRepositories {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession))

    $repositories = @();
    $projects = Get-BitbucketServerProjects

    foreach ( $project in $projects ) {
        $repositories += @((Invoke-RestMethod -Verbose `
            -Method GET `
            -Uri "$($Session.Server)/rest/api/$($Session.Version)/projects/$($project.key)/repos?start=0&limit=10000" `
            -Headers @{
                "Content-Type"= "application/json"
                Authorization = "Basic $($Session.AccessToken)" 
            }).values)
    }
    return  $repositories;
}
