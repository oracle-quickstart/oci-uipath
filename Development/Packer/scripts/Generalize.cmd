%windir%\System32\Sysprep\sysprep.exe /generalize /oobe /quit /unattend:%windir%\Panther\unattend.xml
PowerShell.exe -ExecutionPolicy Unrestricted -File %windir%\Panther\Post-Generalize.ps1
PowerShell.exe -ExecutionPolicy Unrestricted -Command "((Get-Content -Path 'C:\Program Files\bmcs\imageType.json') -replace 'general','custom') | Set-Content -Path 'C:\Program Files\bmcs\imageType.json'" 
PowerShell.exe -ExecutionPolicy Unrestricted -Command "Start-Sleep -Seconds 60"