cd "c:\devop\MitPowershell\QuickScript"
# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

function cdps { set-location "c:\devop\MitPowershell\Quickscript" }
function cdmc { set-location "c:\devop\MitPowershell\Quickscript\MSSComputer" }
function cdpn { set-location "c:\devop\MitPowershell\Quickscript\NewComputer" }
function cdmod { set-location "c:\devop\MitPowershell\Quickscript\MSPSMOD" }
function cd365 { set-location "c:\devop\MitPowershell\365" }
