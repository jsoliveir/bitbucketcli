Function Request-BitbucketCloudBrowserToken {
    param(
        [String] $ClientId,
        [Switch] $Force
    )

    if($env:BITBUCKET_OAUTH_TIME -and $env:BITBUCKET_OAUTH_TOKEN -and $env:BITBUCKET_OAUTH_EXPIRE_IN){
        $IsTokenExpired = [DateTime]::Parse($env:BITBUCKET_OAUTH_TIME).AddSeconds($env:BITBUCKET_OAUTH_EXPIRE_IN) -lt (Get-Date)
        Write-Warning "Retrieving token from the cache"
        if (!$Force -and !$IsTokenExpired){
            return $env:BITBUCKET_OAUTH_TOKEN
        }
    }

    Start-Process `
        "https://bitbucket.org/site/oauth2/authorize?client_id=$ClientId&response_type=token"

    $http = [System.Net.HttpListener]::new() 
    $http.Prefixes.Add("http://localhost:3580/")

    $http.Start()
    if ($http.IsListening) {
        write-host "Attempting to get a Bitbucket token using OIDC flow ..." -f Yellow
        write-host "Opening your browser ..." -f DarkGray
        write-host "Waiting for the token ..." -f DarkGray
    }

    while ($http.IsListening) {
        $context = $http.GetContext()
        if ($context.Request.QueryString.Count -eq 0) {
            [string]$html = "<script>window.location.href = window.location.href.replace('#','?')</script>" 
            $buffer = [System.Text.Encoding]::UTF8.GetBytes($html) # convert htmtl to bytes
            $context.Response.ContentLength64 = $buffer.Length
            $context.Response.OutputStream.Write($buffer, 0, $buffer.Length) #stream to broswer
            $context.Response.OutputStream.Close() 
            continue
        }elseif ($context.Request.Url -like '*access_token*') {
            $env:BITBUCKET_OAUTH_TOKEN = $context.Request.QueryString["access_token"]
            $env:BITBUCKET_OAUTH_EXPIRE_IN = $context.Request.QueryString["expires_in"]
            $env:BITBUCKET_OAUTH_TIME = Get-Date
            [string]$html = "
                <script>window.close()</script>
                <h1>Success!</h1> 
                <p>Token has acquired.</p> You can close this window." 
            $buffer = [System.Text.Encoding]::UTF8.GetBytes($html)
            $context.Response.ContentLength64 = $buffer.Length
            $context.Response.OutputStream.Write($buffer, 0, $buffer.Length)
            $context.Response.OutputStream.Close()
        }
        $http.Close()
        $http.Dispose()
        break;
    }

    if($env:BITBUCKET_OAUTH_TOKEN){
        Write-Host "Successfully Authenticated!`n`n" -f green
    }else{
        throw "Bitbucket OAuth token could not be acquired."
    }
    return $env:BITBUCKET_OAUTH_TOKEN
}
