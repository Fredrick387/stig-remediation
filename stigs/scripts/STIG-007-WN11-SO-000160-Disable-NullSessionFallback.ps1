<#
.SYNOPSIS
Disables NTLM LocalSystem NULL session fallback.

.STIG-ID
WN11-SO-000160

.DESCRIPTION
Enforces DISA STIG WN11-SO-000160 by disabling LocalSystem NULL
session fallback, preventing unauthenticated NTLM access.

.NOTES
Author        : Fredrick Wilson
Date Created  : 2026-01-02
Tested On     : Windows 11 Pro 64-bit (Azure VM)
#>

# Ensure the registry path exists
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0" -Force | Out-Null

# Disable NULL session fallback
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\MSV1_0" `
  -Name "AllowNullSessionFallback" `
  -Type DWord `
  -Value 0

Write-Host "WN11-SO-000160 remediation applied: NULL session fallback disabled." -ForegroundColor Green
