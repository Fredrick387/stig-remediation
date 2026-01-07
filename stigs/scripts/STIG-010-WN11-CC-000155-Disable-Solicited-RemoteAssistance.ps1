<#
.SYNOPSIS
Disables Solicited Remote Assistance.

.STIG-ID
WN11-CC-000155

.DESCRIPTION
Enforces DISA STIG WN11-CC-000155 by disabling Solicited Remote Assistance.
The script first checks the current policy state and only applies changes
if remediation is required.

.NOTES
Author        : Fredrick Wilson
Date Created  : 2026-01-02
Tested On     : Windows 11 Pro 64-bit (Azure VM)
#>

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"

# Ensure policy path exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Read current value
$current = Get-ItemProperty -Path $regPath -Name "fAllowToGetHelp" -ErrorAction SilentlyContinue

# Remediate only if needed
if ($null -eq $current -or $current.fAllowToGetHelp -ne 0) {
    Set-ItemProperty -Path $regPath -Name "fAllowToGetHelp" -Type DWord -Value 0
    Write-Host "WN11-CC-000155 remediation applied: Solicited Remote Assistance disabled." -ForegroundColor Green
}
else {
    Write-Host "Solicited Remote Assistance already disabled. No change required." -ForegroundColor Yellow
}
