
Function Get-BitbucketCloudRepositories {
    param(
        [Parameter(Mandatory=$false)] $Session = (Get-BitbucketSession),
        [Parameter(Mandatory=$false)] [String] $Workspace = $Session.Workspace,
        [Parameter(Mandatory=$false)] [String] $Query="",
        [Parameter(Mandatory=$false)] [Int] $PageLen=100,
        [Parameter(Mandatory=$false)] [Int] $Page=1)
    $repositories= @();
    
    while($true){
        $request = Invoke-RestMethod `
            -Headers @{Authorization = $Session.Authorization } `
            -Uri "$($Session.BaseUrl)/2.0/repositories/${Workspace}?q=${Query}&pagelen=${PageLen}&page=${Page}"
        
        if(!$request.Values) {break;}

        $repositories +=  $request.Values
        
        $Page++
    }
    return $repositories 
}