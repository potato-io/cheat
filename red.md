## Enumeration
### Enumeration | Operating System | Windows Version
- ver
- systeminfo | findstr /B /C:"OS Name" /C:"OS Version"
- powershell>_ ls "$env:windir\system32\ntoskrnl.exe" | select VersionInfo | fl
### Enumeration | Operating System | Patches
- wmic qfe list brief
### Enumeration | Operating System | Windows Tools
- seatbelt all
### Get non standard services installed that are not signed by microsoft
- wmic product get name,version
### Query local or remote RDP sessions
- qwinsta /SERVER:test.lab.local

