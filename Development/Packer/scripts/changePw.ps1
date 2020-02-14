#ps1_sysnative
cmd /C 'wmic UserAccount where Name="opc" set PasswordExpires=False'
$opcUser = get-wmiobject win32_useraccount | Where-Object { $_.Name -match 'opc' }
([adsi]("WinNT://" + $opcUser.caption).replace("\", "/")).SetPassword("1qazXSW@3edc")
