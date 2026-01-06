
```powershell
<#
.SYNOPSIS
Disables the built-in Administrator account identified by RID 500.

.STIG-ID
WN11-SO-000005

.DESCRIPTION
This script enforces compliance with DISA STIG WN11-SO-000005 by locating
the built-in Administrator account using its SID (ending in -500) and
disabling it if currently enabled.

This approach avoids deprecated tools and does not assume the account name.

.NOTES
Author        : <Your Name>
Date Created  : <YYYY-MM-DD>
Tested On     : Windows 11 Pro 64-bit (Azure VM)
#>

# Locate built-in Administrator account by RID 500
$admin = Get-CimInstance Win32_UserAccount |
Where-Object { $_.SID -like '*-500' }

if (-not $admin) {
    Write-Host "Built-in Administrator account not found." -ForegroundColor Red
    exit 1
}

if ($admin.Disabled) {
    Write-Host "Built-in Administrator account is already disabled." -ForegroundColor Yellow
}
else {
    net user "$($admin.Name)" /active:no
    Write-Host "Built-in Administrator account has been disabled." -ForegroundColor Green
}
