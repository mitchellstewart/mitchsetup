$psprofileVersion = "1.2"

Set-Location -Path "c:\devop\MitPowershell\QuickScript"

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

function cdps { set-location "c:\devop\MitPowershell\Quickscript" }
function cdmc { set-location "c:\devop\MitPowershell\Quickscript\MSSComputer" }
function cddc { set-location "c:\devop\MitPowershell\Quickscript\MSSCzDev" }
function cdpn { set-location "c:\devop\MitPowershell\Quickscript\NewComputer" }
function cdmod { set-location "c:\devop\MitPowershell\Quickscript\MSPSMOD" }
function cd365 { set-location "c:\devop\MitPowershell\Quickscript\365" }
function cdg { set-location "c:\devop\MitPowershell\Quickscript\graphapi" }
function cds { set-location "c:\devop\MitPowershell\Quickscript\sync" }
function cdr { 
	set-location "c:\devop\MitPowershell\Quickscript\sync"
	.\repos_gitpull.ps1
}
function cdpsref { set-location "c:\devop\ps" }

# SSH Items
function shat{ ssh mitch@192.168.4.6 }
function deepthought{ ssh mitch@192.168.4.213 }
function rpir3{ ssh mitch@192.168.4.209 }
function rpir3_pi{ ssh pi@192.168.4.209 }
function rpir2{ ssh mitch@192.168.4.210 }

function cdo365 { set-location "c:\devop\OM365\365" }

$t = @"
  __  __ ___ _____ ___ _  _
 |  \/  |_ _|_   _/ __| || |
 | |\/| || |  | || (__| __ |
 |_|  |_|___| |_| \___|_||_|
                                                   
"@
 
for ($i=0;$i -lt $t.length;$i++) {
if ($i % 2) {
 $c = "Green"
}
else {
   $c = "Red"
}
write-host $t[$i] -NoNewline -ForegroundColor $c
}
Write-Host " "
Write-Host "   Version $psprofileVersion" -Foreground "Green"
Write-Host " "