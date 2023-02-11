#Requires -Modules @{ ModuleName="MicrosoftPowerBIMgmt.Profile"; ModuleVersion="1.2.1026"}

$ErrorActionPreference = "Stop"
$VerbosePreference = "SilentlyContinue"

$configFilePath = ".\config.json"

# check that the config file exists
if (Test-Path $configFilePath) {
    $config = Get-Content $configFilePath | ConvertFrom-Json
}
else 
{
    Write-Warning "Cannot find file '$configFilePath' [Exiting script]"
    Start-Sleep -Seconds 2
    Exit
}

# login to the Power BI service using the service principal credentials
try {
    Write-Host "Attempting to login to the Power BI Service using the Service Principal"
    $credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $config.clientId, ($config.clientSecret | ConvertTo-SecureString -AsPlainText -Force)
    Connect-PowerBIServiceAccount -ServicePrincipal -Tenant $config.tenantId -Credential $credential -Environment $config.environment
}
catch {
    Write-Warning "An error occured attempting to login to the Power BI Service."
    Resolve-PowerBIError -Last
    Exit
}

# attempt to query the Power BI REST API for groups/workspaces based on service principal role 
if ($config.isAdmin)
{
    $url = "admin/groups?`$top=10"
}
else {
    $url = "groups?`$top=10"
}

try {
    $result = Invoke-PowerBIRestMethod -Url $url -Method Get | ConvertFrom-Json
    Write-Host "Power BI Workspaces returned: $($result.value.count)"
    Write-Host -ForegroundColor Green "The service principal is configured to use the Power BI REST APIs"
}
catch {
    Write-Warning "An error occured attempting to query the Power BI REST API"
    Resolve-PowerBIError -Last
}
finally {
    Disconnect-PowerBIServiceAccount
}
