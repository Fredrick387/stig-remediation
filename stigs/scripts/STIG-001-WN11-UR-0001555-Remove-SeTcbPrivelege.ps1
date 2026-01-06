<#
.SYNOPSIS
Removes all assignments for the "Act as part of the operating system" user right.

.STIG-ID
WN11-UR-000155

.DESCRIPTION
This script enforces compliance with STIG WN11-UR-000155 by ensuring that
the SeTcbPrivilege (Act as part of the operating system) user right is not
assigned to any users or groups.

The compliant state requires the privilege to exist with no assignments.
Windows does not persistently display an explicit "empty" state, so compliance
is validated by confirming no effective assignments exist.

.NOTES
Author        : Fredrick Wilson
Date Created  : 2026-01-01
Tested On     : Windows 11 Enterprise 64-bit
#>

# Define temporary security policy export path
$cfgPath = "$env:TEMP\secpol.cfg"

# Export current local security policy
secedit /export /cfg $cfgPath /quiet

# Remove any existing SeTcbPrivilege assignments
(Get-Content $cfgPath) |
    ForEach-Object {
        if ($_ -match '^SeTcbPrivilege') {
            'SeTcbPrivilege ='
        }
        else {
            $_
        }
    } | Set-Content $cfgPath

# Apply the updated User Rights Assignment configuration
secedit /configure /db secedit.sdb /cfg $cfgPath /areas USER_RIGHTS /quiet

# Optional: Output status message
Write-Host "WN11-UR-000155 remediation applied. Verify with 'whoami /priv'." -ForegroundColor Green
