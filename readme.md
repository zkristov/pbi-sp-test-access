# Power BI Service Principal (Test Access)

This script tests service principal access against the Power BI REST APIs.

Requires the setup of a service principal(s) to use the Power BI REST APIs.
- Follow these instructions to setup a service principal...

## Instructions
Make sure you have the Powershell cmdlet [MicrosoftPowerBIMgmt.Profile] (https://learn.microsoft.com/en-us/powershell/module/microsoftpowerbimgmt.profile/?view=powerbi-ps) installed.

1. Copy `config.example.json` to `config.json`
2. Update `config.json` with your desired values
3. Run `run.ps1`