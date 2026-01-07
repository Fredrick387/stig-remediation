
---

## 2️⃣ **Standalone PowerShell Script**

**Filename (recommended):**  
`STIG-005-WN11-CC-000350-Disable-WinRM-UnencryptedTraffic.ps1`

```powershell
<#
.SYNOPSIS
Disables unencrypted traffic for the WinRM service.

.STIG-ID
WN11-CC-000350

.DESCRIPTION
Enforces DISA STIG WN11-CC-000350 by configuring the WinRM service
to disallow unencrypted traffic, ensuring management communications
are protected.

.NOTES
Author        : Fredrick Wilson
Date Created  : 2026-01-02
Tested On     : Windows 11 Pro 64-bit (Azure VM)
#>

# Ensure the policy registry path exists
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service" -Force | Out-Null

# Disable unencrypted WinRM traffic
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service" `
  -Name "AllowUnencryptedTraffic" `
  -Type DWord `
  -Value 0

Write-Host "WN11-CC-000350 remediation applied: WinRM unencrypted traffic disabled." -ForegroundColor Green

