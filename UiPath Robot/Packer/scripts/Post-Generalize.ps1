Try {
    Start-Transcript -Path $Env:WinDir\Panther\Post-Generalize.log

    Write-Host "Current CmdLine"
    Get-ItemProperty -Path "HKLM:\System\Setup" -Name "CmdLine"

    Write-Host "Updating CmdLine"
    Set-ItemProperty -Path "HKLM:\System\Setup" -Name "CmdLine" -Value "$Env:WinDir\Panther\Specialize.cmd"

    Write-Host "New CmdLine"
    Get-ItemProperty -Path "HKLM:\System\Setup" -Name "CmdLine"
}
Catch {
    Write-Host $_
}
Finally {
    Stop-Transcript
} 
