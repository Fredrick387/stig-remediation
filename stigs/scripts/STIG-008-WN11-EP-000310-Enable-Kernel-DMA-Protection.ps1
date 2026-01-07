<#
.SYNOPSIS
Enables Kernel DMA Protection policy.

.STIG-ID
WN11-EP-000310

.DESCRIPTION
Enforces DISA STIG WN11-EP-000310 by configuring the Kernel DMA Protection
policy to block incompatible external devices, reducing DMA attack risk.

.NOTES
Author        : Fredrick Wilson
Date Created  : 2026-01-02
Tested On     : Windows 11 Pro 64-bit (Azure VM)
#>

# Ensure the policy registry path exists
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Kernel DMA Protection" -Force | Out-Null

# Enable Kernel DMA Protection policy
Set-ItemProperty `
  -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Kernel DMA Protection" `
  -Name "DeviceEnumerationPolicy" `
  -Type DWord `
  -Value 1

Write-Host "WN11-EP-000310 remediation applied: Kernel DMA Protection policy enforced." -ForegroundColor Green
