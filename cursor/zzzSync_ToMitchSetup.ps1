$projectName = "mitchsetup"
$userNameFolder = "mitch"
$source = "C:\devop\MitPowershell\QuickScript\cursorchange"

$backupLocation = "C:\devop\mitchsetup\cursor"
# $backupLocation = "C:\!tech\QuickScript"

if(Test-Path -Path $backupLocation){
    Write-Host "Backup Directory: $backupLocation" -ForegroundColor "Cyan"

    robocopy  $source $backupLocation /MIR /R:0 /W:0 #/NFL /NDL /COPYALL /B /SEC 

}
else{
    Write-Host "Backup Directory not found: $backupLocation" -ForegroundColor "Red"
}


