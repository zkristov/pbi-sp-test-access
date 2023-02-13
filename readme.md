# Power BI Service Principal (Test Access)
This script tests access to the [Power BI REST APIs](https://learn.microsoft.com/en-us/rest/api/power-bi/) using a Service Principal.

Requires the setup of a service principal to use the Power BI REST APIs.
- [Create an Azure AD App (aka Service Principal)](https://learn.microsoft.com/en-us/azure/active-directory/develop/howto-create-service-principal-portal)
- [Create an Azure AD Security Group](https://learn.microsoft.com/en-us/azure/active-directory/fundamentals/active-directory-groups-create-azure-portal)
- [Enable the Power BI Tenant settings](https://learn.microsoft.com/en-us/power-bi/enterprise/service-premium-service-principal#enable-service-principals)
- [Optional: Add Azure AD Security Group to Workspace](https://learn.microsoft.com/en-us/power-bi/enterprise/service-premium-service-principal#workspace-access)

## Instructions
Make sure you have the Powershell cmdlet [MicrosoftPowerBIMgmt.Profile](https://learn.microsoft.com/en-us/powershell/module/microsoftpowerbimgmt.profile/?view=powerbi-ps) installed.

1. Copy `config.example.json` to `config.json`
2. Update `config.json` with your desired values*
3. Execute `run.ps1`

*Below are the defintions for `config.json`:  
| Setting      | Description
| ----------- | --------- | 
| tenantId   | The Azure AD tenant id |  
| clientId   | The Azure AD App id |  
| clientSecret   | The Azure AD App secret |  
| environment   | The Power BI environment type (i.e., Public, USGov, Germany, etc.) |  
| isAdmin   | Flags if the service principal has access to the Power BI read-only admin APIs |  

## Troubleshooting
The most common error returned is a `401 - Unauthorized`, which typically indicates the service principal does not have access to the Power BI REST API.
To resolve this error, check the following:
1) Has the Azure AD Security Group (containing the service principal) been added to the [Power BI Tenant settings](https://learn.microsoft.com/en-us/power-bi/enterprise/service-premium-service-principal#enable-service-principals)?  
_The Azure AD Security group must be added to the proper Power BI Tenant setting(s) for authorization._
2) Has the Azure AD Security Group (containing the service principal) been added to the Power BI Workspace with at least workspace Member privileges?  
_In order for your service principal to have the necessary permissions to perform Premium workspace and dataset operations, you must add the service principal as a workspace Member or Admin.  
Note: This is not required if using the [Power BI read-only admin APIs](https://learn.microsoft.com/en-us/power-bi/enterprise/read-only-apis-service-principal-authentication)._
3) Does the Azure AD App (aka service principal) have any Power BI API permissions granted?  
_There should be no API permissions (delegated or application) granted to the service principal. The Power BI REST API handles the required permissions to access the service endpoints._
