Function New-BitbucketCloudCommit{
   param([Parameter(Mandatory=$false)] [PSCustomObject] $Session = (Get-BitbucketSession),
         [Parameter(Mandatory=$false)] [String] $Workspace = $Session.Workspace,
         [Parameter(Mandatory=$true)]  [String]    $Repository,
         [Parameter(Mandatory=$false)] [String]    $Path,
         [Parameter(Mandatory=$false)] [String]    $Content,
         [Parameter(Mandatory=$false)] [String]    $Message,
         [Parameter(Mandatory=$false)] [String]    $Author,
         [Parameter(Mandatory=$false)] [String]    $Branch="master",
         [Parameter(Mandatory=$false)] [Switch]    $Delete
         )
         
     $body = @{
        message =$Message
        branch = $Branch
        author = $Author
     };
     
     if($Delete) { $Content = $null}

     if($Path){ ([void] $body.Add($Path, $Content)) }

     return  (Invoke-RestMethod `
        -Method POST `
        -Uri "$($Session.BaseUrl)/2.0/repositories/$Workspace/$Repository/src/" `
        -Headers @{ 
            Authorization = $Session.Authorization
            ContentType ='application/x-www-form-urlencode'
           } `
        -Body $body)
}