Function Get-BitbucketServerDirectoryContent {
    param(
        [Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
        [Parameter(Mandatory=$true)] $ProjectKey,
        [Parameter(Mandatory=$true)] $Repository
        )

        $start = 0
        $limit = 100
        $done = $false
        $values = New-Object System.Collections.ArrayList($null)

        while (-not($done))
        {
            $result = (Invoke-RestMethod `
                -Method GET `
                -Uri "$($Session.Server)/rest/api/$($Session.Version)/projects/$ProjectKey/repos/$Repository/files?start=$start&limit=$limit" `
                -Headers @{
                    "Content-Type"= "application/json"
                    Authorization = $Session.Authorization 
                })
    
            $values.AddRange($result.values)
            $start = $result.nextPageStart
            $done = $result -eq $null -or $result.isLastPage
        }
        return $values
}
