Function Get-BitbucketServerRepositories {
    param([Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession))

    $repositories = @();
    $projects = Get-BitbucketServerProjects `
        -Session $Session

    foreach ( $project in $projects ) {
        $repositories += @((Invoke-RestMethod `
            -Method GET `
            -Uri "$($Session.BaseUrl)/rest/api/2.0/projects/$($project.key)/repos?start=0&limit=10000" `
            -Headers @{
                "Content-Type"= "application/json"
                Authorization = $Session.Authorization 
            }).values)
    }
    return  $repositories;
}
