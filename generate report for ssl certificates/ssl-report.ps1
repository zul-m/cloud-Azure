param(
    [Parameter(Mandatory = $False, Position = 0, ValueFromPipeline = $false)]
    [System.Int32]
    $minimumCertAgeDays = 30
)

# Get the list of links to scan
$NameList = get-content C:\ssl\SSLDEMO\urls.txt 
$Results = @()

# SSL variables
# $minimumCertAgeDays = 60
$timeoutMilliseconds = 15000
# Disabling the cert validation check
# This is what makes this whole thing work with invalid certs...
[Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }


foreach ($Name in $NameList) {
    $OutputObject = "" | Select-Object Type, OriginUrl, Name,Hostnames,Gateway, IPAddress, Status, SSLStartDAY, SSLENDDAY, SSENDINDAYS, StatusSSLMinAge, ErrorMessage 
    try {
        $domain = ([System.URI]$Name).host.Trim()
        $dnsRecord = Resolve-DnsName $domain
        $OutputObject.Name = $($dnsRecord.Name -join ',')
        $OutputObject.OriginUrl = $Name
        $OutputObject.Type = $($dnsRecord.Type -join ',')
        $OutputObject.IPAddress = ($dnsRecord.IPAddress -join ',')
        switch ($dnsRecord.IPAddress)
        {
            $ipGatewayOne
            {
                $OutputObject.Gateway = 'Gateway1'
            }
            
            # Default state
            Default
            {
                $OutputObject.Gateway = ''
            }
        }
        $OutputObject.Status = 'OK'
        $OutputObject.ErrorMessage = ''
        $OutputObject.Hostnames=($dnsRecord.NameHost -join ',')
        
        # SSL stuff
        Write-Host Checking $Name -f Green
        $req = [Net.HttpWebRequest]::Create($Name)
        $req.Timeout = $timeoutMilliseconds
        $req.AllowAutoRedirect = $true
        try {
            $req.GetResponse() | Out-Null
        }
        catch {
            Write-Host Exception while checking URL $Name`: $_ -f Red
        }
        
        $certExpiresOnString = $req.ServicePoint.Certificate.GetExpirationDateString()
        # Write-Host "Certificate expires on (string): $certExpiresOnString"
        [datetime]$expiration = [System.DateTime]::Parse($req.ServicePoint.Certificate.GetExpirationDateString())
        # Write-Host "Certificate expires on (datetime): $expiration"
        [int]$certExpiresIn = ($expiration - $(get-date)).Days
        $certName = $req.ServicePoint.Certificate.GetName()
        $certPublicKeyString = $req.ServicePoint.Certificate.GetPublicKeyString()
        $certSerialNumber = $req.ServicePoint.Certificate.GetSerialNumberString()
        $certThumbprint = $req.ServicePoint.Certificate.GetCertHashString()
        $certEffectiveDate = $req.ServicePoint.Certificate.GetEffectiveDateString()
        $certIssuer = $req.ServicePoint.Certificate.GetIssuerName()
        $OutputObject.SSLStartDAY = $certEffectiveDate 
        $OutputObject.SSLENDDAY = $expiration
        $OutputObject.SSENDINDAYS = $certExpiresIn 
        
        if ($certExpiresIn -gt $minimumCertAgeDays)
        {
            Write-Host Cert for site $Name expires in $certExpiresIn days [on $expiration] -f Green
            $OutputObject.StatusSSLMinAge = 'ok'
        }
        else {
            Write-Host WARNING: Cert for site $Name expires in $certExpiresIn days [on $expiration] -f Red
            $OutputObject.StatusSSLMinAge = 'ko'
        }
        #END SSL STUFF
    }
    
    catch {
        $OutputObject.Name = $Name
        $OutputObject.IPAddress = ''
        $OutputObject.Status = 'NOT_OK'
        $OutputObject.ErrorMessage = $_.Exception.Message
    }
    
    $Results += $OutputObject
}

return $Results | Export-Csv C:\ssl\SSLDEMO\sslresultsnew.csv -NoTypeInformation