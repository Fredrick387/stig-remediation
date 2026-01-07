
---

## 2️⃣ **Standalone PowerShell Script**

**Filename (recommended):**  
`STIG-004-WN11-CC-000330-Disable-WinRMClient-BasicAuth.ps1`

```powershell
<#
.SYNOPSIS
Disables WinRM Client Basic authentication.

.STIG-ID
WN11-CC-000330

.DESCRIPTION
Enforces DISA STIG WN11-CC-000330 by disabling Basic authentication for the
WinRM client. This prevents the use of plaintext credentials during remote
management operations.

.NOTES
Author        : FredrickWilson
Date Created  : 2026-01-02
Tested On     : Windows 11 Pro 64-bit (Azure VM)
#>

# Ensure the policy registry path exists
New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client" -Force | Out-Null

# Disable WinRM Client Basic authentication
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Client" -Name "AllowBasic" -Type DWord -Value 0

Write-Host "WN11-CC-000330 remediation applied: WinRM Client Basic authentication disabled." -ForegroundColor Green
