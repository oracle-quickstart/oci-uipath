 REM The network adapter sometimes does not come up on time.
PowerShell.exe -ExecutionPolicy Unrestricted -Command "if ($(Get-Service -Name Dhcp).Status -ne 'Running'){Start-Service -Name Dhcp}"
PowerShell.exe -ExecutionPolicy Unrestricted -Command "Start-Sleep -Seconds 10"
PowerShell.exe -ExecutionPolicy Unrestricted -Command "Invoke-WebRequest -UseBasicParsing -Uri http://169.254.0.5/specialize/Install-Specialization.ps1 -OutFile %windir%\Panther\Install-Specialization.ps1"

if not exist %windir%\Panther\Install-Specialization.ps1 (
REM The network adapter may not still be up.
	PowerShell.exe -ExecutionPolicy Unrestricted -Command "Start-Sleep -Seconds 20"
	ipconfig /renew
	PowerShell.exe -ExecutionPolicy Unrestricted -Command "Start-Sleep -Seconds 15"
	PowerShell.exe -ExecutionPolicy Unrestricted -Command "Invoke-RestMethod -Uri http://169.254.0.5/specialize/Install-Specialization.ps1 -OutFile %windir%\Panther\Install-Specialization.ps1"
)

ipconfig

REM Wait for file write to complete and process handle release.
PowerShell.exe -ExecutionPolicy Unrestricted -Command "Start-Sleep -Seconds 3"
PowerShell.exe -ExecutionPolicy Unrestricted -Command "Start-Transcript %windir%\Panther\Install-Specialization.log; %windir%\Panther\Install-Specialization.ps1; Stop-Transcript"
netsh advfirewall firewall add rule name="Open Port 3389" dir=in action=allow protocol=TCP localport=3389
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
%windir%\System32\oobe\windeploy.exe
