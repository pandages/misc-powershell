<# #############################################################################
## NAME:    PSstart.PS1
## CONTRIB: Kaishi Axon, XyberICE(StackOverflow)
## DATE:    7 December 2016
##
## This script's purpose is to be used from a DOS prompt or scheduled task, to
## launch a process with specified affinity and priority.
##
## USAGE:   PowerShell -file PSStart.ps1 -affinity <affinity> -priority 
##          <priority> <path to executable> <executable arguments>
## SOURCE:  https://stackoverflow.com/a/41028131
##
## #############################################################################
##
## ARGUMENTS:
##     -affinity
##         expressed as a bitmask of the intended CPU cores.  To find the right
##         mask, use Task Manager to set the intended cores, and then use:
##         Get-Procecss -name <window name> | fl ProcessorAffinity
##         This will return the Bitmask you need for those cores.
##     -priority
##         expressed as the name of the process priority, all caps no spaces.
##         LOW, BELOWNORMAL, NORMAL, ABOVENORMAL, HIGH, REALTIME
##     Path to Executable
##         expressed as a string
##     Executable Arguments
##         expressed as a string
##
## #############################################################################
#>

param(
    [Int32]$affinity=0xF,
    [String]$priority="NORMAL",
    [String]$appPath="",
    [String]$appArguments=""
)

[System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")   # For message box error reports, remove if you don't want popup errors

$priorityValues = "LOW", "NORMAL", "HIGH", "REALTIME", "ABOVENORMAL", "BELOWNORMAL"
$priorityUC = $priority.ToUpper()
$pinfo = New-Object System.Diagnostics.ProcessStartInfo

If($appPath -ne "" -and (Test-Path $appPath))
{
    If($priorityValues -contains $priorityUC)
    {
        Try
        {
            $pinfo.FileName = $appPath
            $pinfo.Arguments = $app_arguments
            $p = New-Object System.Diagnostics.Process
            $p.StartInfo = $pinfo
            $p.Start()
            $p.PriorityClass=$priorityUC
            $p.ProcessorAffinity=$affinity
        }
        Catch
        {
            $exceptionMessage = $_.Exception.Message
            #Write-Host "An exception:`n`n$exceptionMessage`n`noccured!" -fore white -back red  # Uncomment for console errors
            [System.Windows.Forms.MessageBox]::Show("An exception:`n`n$exceptionMessage`n`noccured!", "An Exception Occured", "Ok", "Error");
            Break
        }
    }
    Else
    {
        #Write-Host "The priority: `"$priorityUC`" is not a valid priority value!" -fore white -back red    # Uncomment for console errors
        [System.Windows.Forms.MessageBox]::Show("The priority: `"$priorityUC`" is not a valid priority value!", "A Priority Error Occured", "Ok", "Error");
    }
}
Else
{
    #Write-Host "The application path: `"$appPath`" doesn't exist!", "A Path Error Occured" -fore white -back red   # Uncomment for console errors
    [System.Windows.Forms.MessageBox]::Show("The application path: `"$appPath`" doesn't exist!", "A Path Error Occured", "Ok", "Error");
}