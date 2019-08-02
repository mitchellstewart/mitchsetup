<# 
.SYNOPSIS
Install the yellow mouse cursor theme.
#>

<#
Article https://blogs.technet.microsoft.com/heyscriptingguy/2013/01/17/use-powershell-to-change-the-mouse-pointer-scheme/
Article http://thecomputermanagersden.blogspot.com/2014/05/powershell-script-to-customize-windows.html
SystmParametersInfo https://msdn.microsoft.com/en-us/library/windows/desktop/ms724947(v=vs.85).aspx
#>

# copy cursors
Copy-Item msred_*.ani C:\Windows\Cursors\ -Force -ErrorAction SilentlyContinue
Copy-Item msred_*.cur C:\Windows\Cursors\ -Force -ErrorAction SilentlyContinue

# create Yellow scheme
$regKeyCursor = 'HKCU:\Control Panel\Cursors'
$cursorSystemPath = '%SystemRoot%\cursors'

if (!(Test-Path "$regKeyCursor\Schemes")) { $null = New-Item -Path $regKeyCursor -Name 'Schemes' -Force }
$null = New-ItemProperty -Path "$regKeyCursor\Schemes" -Force -Name 'MSRed' -Value "$cursorSystemPath\msred_arrow.cur,$cursorSystemPath\msred_helpsel.cur,$cursorSystemPath\msred_working.ani,$cursorSystemPath\aero_busy.ani,,,$cursorSystemPath\msred_pen.cur,$cursorSystemPath\aero_unavail.cur,$cursorSystemPath\msred_ns.cur,$cursorSystemPath\msred_ew.cur,$cursorSystemPath\msred_nwse.cur,$cursorSystemPath\msred_nesw.cur,$cursorSystemPath\msred_move.cur,$cursorSystemPath\msred_up.cur,$cursorSystemPath\msred_link.cur,$cursorSystemPath\msred_pin.cur,$cursorSystemPath\msred_person.cur"

# apply Yellow scheme
Set-Item $regKeyCursor -Value 'MSRed' -Force
$null = New-ItemProperty $regKeyCursor -Name 'AppStarting' -Value "$cursorSystemPath\msred_working.ani" -Force
$null = New-ItemProperty $regKeyCursor -Name 'Arrow' -Value "$cursorSystemPath\msred_arrow.cur" -Force
$null = New-ItemProperty $regKeyCursor -Name 'Crosshair' -Value '' -Force
$null = New-ItemProperty $regKeyCursor -Name 'Hand' -Value "$cursorSystemPath\msred_link.cur" -Force
$null = New-ItemProperty $regKeyCursor -Name 'Help' -Value "$cursorSystemPath\msred_helpsel.cur" -Force
$null = New-ItemProperty $regKeyCursor -Name 'IBeam' -Value '' -Force
$null = New-ItemProperty $regKeyCursor -Name 'No' -Value "$cursorSystemPath\aero_unavail.cur" -Force
$null = New-ItemProperty $regKeyCursor -Name 'NWPen' -Value "$cursorSystemPath\msred_pen.cur" -Force
$null = New-ItemProperty $regKeyCursor -Name 'Person' -Value "$cursorSystemPath\msred_person.cur" -Force
$null = New-ItemProperty $regKeyCursor -Name 'Pin' -Value "$cursorSystemPath\msred_pin.cur" -Force
$null = New-ItemProperty $regKeyCursor -Name 'SizeAll' -Value "$cursorSystemPath\msred_move.cur" -Force
$null = New-ItemProperty $regKeyCursor -Name 'SizeNESW' -Value "$cursorSystemPath\msred_nesw.cur" -Force
$null = New-ItemProperty $regKeyCursor -Name 'SizeNS' -Value "$cursorSystemPath\msred_ns.cur" -Force
$null = New-ItemProperty $regKeyCursor -Name 'SizeNWSE' -Value "$cursorSystemPath\msred_nwse.cur" -Force
$null = New-ItemProperty $regKeyCursor -Name 'SizeWE' -Value "$cursorSystemPath\msred_ew.cur" -Force
$null = New-ItemProperty $regKeyCursor -Name 'UpArrow' -Value "$cursorSystemPath\msred_up.cur" -Force
$null = New-ItemProperty $regKeyCursor -Name 'Wait' -Value "$cursorSystemPath\aero_busy.ani" -Force

# Scheme Source -- 0=Windows Default, 1=User Scheme, 2=System Scheme
$null = New-ItemProperty $regKeyCursor -Name 'Scheme Source' -Value 1 -Type dword -Force

# reload system cursors
$cs = @'
[DllImport("user32.dll", SetLastError = true, EntryPoint = "SystemParametersInfo")]
[return: MarshalAs(UnmanagedType.Bool)]
public static extern bool SystemParametersInfo(uint uiAction, uint uiParam, bool pvParam, uint fWinIni);
'@
 
$SPI_SETCURSORS = 0x0057
$CursorRefresh = Add-Type -MemberDefinition $cs -Name WinAPICall -Namespace SystemParamInfo –PassThru
$CursorRefresh::SystemParametersInfo($SPI_SETCURSORS, 0, $null, 0)
