
<#
.SYNOPSIS
Disables the SMBv1 protocol on the SMB server.

.STIG-ID
WN11-CC-000370

.DESCRIPTION
Enforces DISA STIG WN11-CC-000370 by disabling the SMBv1 protocol,
which is deprecated and vulnerable to multiple attack techniques.

.NOTES
Author        : Fredrick Wilson
Date Created  : 2026-01-02
Tested On     : Windows 11 Pro 64-bit (Azure VM)
#>

# Ensure the registry path exists
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Force | Out-Null

# Disable SMBv1
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "SMB1" -Type DWord -Value 0

Write-Host "WN11-CC-000370 remediation applied: SMBv1 disabled." -ForegroundColor Green
