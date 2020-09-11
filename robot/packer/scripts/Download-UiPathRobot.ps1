
[CmdletBinding()]
Param()
$sLogPath = "C:\Windows\Temp"
$sLogName = "Download-UiPathRobot.log"
$sLogFile = Join-Path -Path $sLogPath -ChildPath $sLogName
$script:tempDirectory = (Join-Path $ENV:TEMP "UiPath-$(Get-Date -f "yyyyMMddhhmmssfff")")
$logPath = Join-Path $script:tempDirectory "install.log"

$UiPathRobotVersions = "20.4.3","19.10.5","19.4.6","18.4.8"

function Main {

    Process {

        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        
        $msiPathArray = New-Object System.Collections.ArrayList
        
        foreach ($robotVersion in $UiPathRobotVersions) {
            
            $robotArtifactURL = "https://download.uipath.com/versions/$robotVersion/UiPathStudio.msi"

            $robotFolder = New-Item -Path "C:\Windows\Temp\" -Name "robotArtifactFolder$robotVersion" -ItemType Directory | Select-Object FullName

            $artifactFileName = "UiPathStudio.msi"

            $msiPath = Join-Path -Path $robotFolder.FullName -ChildPath $artifactFileName
            
            #void ignores the return index value from the Add method
            [void]$msiPathArray.Add($msiPath)

            Download-Files -url $robotArtifactURL -outputFile $msiPath

        }
        While (((Test-IsFileLocked -Path $msiPathArray[0]) -eq "True") -or ((Test-IsFileLocked -Path $msiPathArray[1]) -eq "True") -or ((Test-IsFileLocked -Path $msiPathArray[2]) -eq "True")) {

        }
    }
}

<#
  .DESCRIPTION
  Downloads a file from a URL

  .PARAMETER url
  The URL to download from

  .PARAMETER outputFile
  The local path where the file will be downloaded
#>
function Download-Files {

    param (
        [Parameter(Mandatory = $true)]
        [string]$url,
  
        [Parameter(Mandatory = $true)]
        [string] $outputFile
    )
    
    Write-Verbose "Downloading file from $url to local path $outputFile"

    Try {
  
        $webClient = New-Object System.Net.WebClient
        
        $webClient.DownloadFileAsync($url, $outputFile)

    }
      
    Catch {
      
        Log-Error -LogPath $sLogFile -ErrorDesc "The following error occurred: $_" -ExitGracefully $True
      
    }
}

Function Test-IsFileLocked {
    [cmdletbinding()]
    Param (
        [parameter(Mandatory=$True,ValueFromPipeline=$True,ValueFromPipelineByPropertyName=$True)]
        [Alias('FullName','PSPath')]
        [string[]]$Path
    )
    Process {
        ForEach ($Item in $Path) {
            #Ensure this is a full path
            $Item = Convert-Path $Item
            #Verify that this is a file and not a directory
            If ([System.IO.File]::Exists($Item)) {
                Try {
                    $FileStream = [System.IO.File]::Open($Item,'Open','Write')
                    $FileStream.Close()
                    $FileStream.Dispose()
                    $IsLocked = $False

                } Catch [System.UnauthorizedAccessException] {
                    $IsLocked = 'AccessDenied'
                } Catch {
                    $IsLocked = $True
                }
                return $IsLocked
            }
        }
    }
}


function Log-Error {

    [CmdletBinding()]
  
    param (
        [Parameter(Mandatory = $true)]
        [string]$LogPath,
  
        [Parameter(Mandatory = $true)]
        [string]$ErrorDesc,
  
        [Parameter(Mandatory = $true)]
        [boolean]$ExitGracefully
    )
  
    Process {
        Add-Content -Path $LogPath -Value "Error: An error has occurred [$ErrorDesc]."
  
        #Write to screen for debug mode
        Write-Debug "Error: An error has occurred [$ErrorDesc]."
  
        #If $ExitGracefully = True then run Log-Finish and exit script
        If ($ExitGracefully -eq $True) {
            Log-Finish -LogPath $LogPath
            Break
        }
    }
}

function Log-Finish {

    [CmdletBinding()]
  
    param (
        [Parameter(Mandatory = $true)]
        [string]$LogPath,
  
        [Parameter(Mandatory = $false)]
        [string]$NoExit
    )
  
    Process {
        Add-Content -Path $LogPath -Value ""
        Add-Content -Path $LogPath -Value "***************************************************************************************************"
        Add-Content -Path $LogPath -Value "Finished processing at [$([DateTime]::Now)]."
        Add-Content -Path $LogPath -Value "***************************************************************************************************"
        Add-Content -Path $LogPath -Value ""
  
        #Write to screen for debug mode
        Write-Debug ""
        Write-Debug "***************************************************************************************************"
        Write-Debug "Finished processing at [$([DateTime]::Now)]."
        Write-Debug "***************************************************************************************************"
        Write-Debug ""
  
        #Exit calling script if NoExit has not been specified or is set to False
        If (!($NoExit) -or ($NoExit -eq $False)) {
            Exit
        }
    }
}

Main
Log-Finish -LogPath $sLogFile

