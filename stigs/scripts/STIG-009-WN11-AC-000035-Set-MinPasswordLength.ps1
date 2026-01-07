`STIG-009-WN11-AC-000035-Set-MinPasswordLength.ps1`

<#
.SYNOPSIS
Enforces a minimum password length of 14 characters.

.STIG-ID
WN11-AC-000035

.DESCRIPTION
Applies a local security policy using a temporary INF template to set
the minimum password length to 14 characters, in compliance with DISA STIG
requirements.

.NOTES
Author        : Fredrick Wilson
Date Created  : 2026-01-02
Tested On     : Windows 11 Pro 64-bit (Azure VM)
#>

$infPath = "$env:TEMP\minpwd.inf"

@"
[System Access]
MinimumPasswordLength = 14
"@ | Set-Content -Path $infPath -Encoding ASCII

secedit /configure /db secedit.sdb /cfg $infPath /areas SECURITYPOLICY /quiet

Write-Host "WN11-AC-000035 remediation applied: Minimum password length set to 14." -ForegroundColor Green
