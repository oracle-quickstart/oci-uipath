#ps1_sysnative
cmd /C 'wmic UserAccount where Name="opc" set PasswordExpires=False'
$opcUser = get-wmiobject win32_useraccount | Where-Object { $_.Name -match 'opc' }
([adsi]("WinNT://" + $opcUser.caption).replace("\", "/")).SetPassword("<your password here, should be the same password in generalized-rdp.json>")