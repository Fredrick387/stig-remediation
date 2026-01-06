<#
.SYNOPSIS
Restricts the "Debug programs" user right to the Administrators group only.

.STIG-ID
WN11-UR-000150

.DESCRIPTION
This script enforces compliance with STIG WN11-UR-000150 by ensuring that the
SeDebugPrivilege (Debug programs) user right is assigned only to the local
Administrators group.

The compliant state allows Administrators to retain this privilege while
preventing assignment to non-administrative users or groups.

.NOTES
Author        : <Your Name>
Date Created  : <YYYY-MM-DD>
Tested On     : Windows 11 Pro / Enterprise 64-bit (Azure VM)
#>

# Define temporary security policy export path
$cfgPath = "$env:TEMP\secpol.cfg"

# Export current local security policy
secedit /export /cfg $cfgPath /quiet

# Restrict SeDebugPrivilege to Administrators only (SID: S-1-5-32-544)
(Get-Content $cfgPath) |
    ForEach-Object {
        if ($_ -match '^SeDebugPrivilege') {
            'SeDebugPrivilege = *S-1-5-32-544'
        }
        else {
            $_
        }
    } | Set-Content $cfgPath

# Apply updated User Rights Assignment configuration
secedit /configure /db secedit.sdb /cfg $cfgPath /areas USER_RIGHTS /quiet

# Optional confirmation output
Write-Host "WN11-UR-000150 remediation applied. Verify via Local Security Policy or secedit export." -ForegroundColor Green
