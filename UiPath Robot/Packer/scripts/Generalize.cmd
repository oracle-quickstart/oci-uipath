%windir%\System32\Sysprep\sysprep.exe /generalize /oobe /quit /unattend:%windir%\Panther\unattend.xml
PowerShell.exe -ExecutionPolicy Unrestricted -File %windir%\Panther\Post-Generalize.ps1
PowerShell.exe -ExecutionPolicy Unrestricted -Command "Start-Sleep -Seconds 60"