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
Copy-Item msblue_*.ani C:\Windows\Cursors\ -Force -ErrorAction SilentlyContinue
Copy-Item msblue_*.cur C:\Windows\Cursors\ -Force -ErrorAction SilentlyContinue

# create Yellow scheme
$regKeyCursor = 'HKCU:\Control Panel\Cursors'
$cursorSystemPath = '%SystemRoot%\cursors'

if (!(Test-Path "$regKeyCursor\Schemes")) { $null = New-Item -Path $regKeyCursor -Name 'Schemes' -Force }
$null = New-ItemProperty -Path "$regKeyCursor\Schemes" -Force -Name 'MSBlue' -Value "$cursorSystemPath\msblue_arrow.cur,$cursorSystemPath\msblue_helpsel.cur,$cursorSystemPath\msblue_working.ani,$cursorSystemPath\aero_busy.ani,,,$cursorSystemPath\msblue_pen.cur,$cursorSystemPath\aero_unavail.cur,$cursorSystemPath\msblue_ns.cur,$cursorSystemPath\msblue_ew.cur,$cursorSystemPath\msblue_nwse.cur,$cursorSystemPath\msblue_nesw.cur,$cursorSystemPath\msblue_move.cur,$cursorSystemPath\msblue_up.cur,$cursorSystemPath\msblue_link.cur,$cursorSystemPath\msblue_pin.cur,$cursorSystemPath\msblue_person.cur"

# apply Yellow scheme
Set-Item $regKeyCursor -Value 'MSBlue' -Force
$null = New-ItemProperty $regKeyCursor -Name 'AppStarting' -Value "$cursorSystemPath\msblue_working.ani" -Force
$null = New-ItemProperty $regKeyCursor -Name 'Arrow' -Value "$cursorSystemPath\msblue_arrow.cur" -Force
$null = New-ItemProperty $regKeyCursor -Name 'Crosshair' -Value '' -Force
$null = New-ItemProperty $regKeyCursor -Name 'Hand' -Value "$cursorSystemPath\msblue_link.cur" -Force
$null = New-ItemProperty $regKeyCursor -Name 'Help' -Value "$cursorSystemPath\msblue_helpsel.cur" -Force
$null = New-ItemProperty $regKeyCursor -Name 'IBeam' -Value '' -Force
$null = New-ItemProperty $regKeyCursor -Name 'No' -Value "$cursorSystemPath\aero_unavail.cur" -Force
$null = New-ItemProperty $regKeyCursor -Name 'NWPen' -Value "$cursorSystemPath\msblue_pen.cur" -Force
$null = New-ItemProperty $regKeyCursor -Name 'Person' -Value "$cursorSystemPath\msblue_person.cur" -Force
$null = New-ItemProperty $regKeyCursor -Name 'Pin' -Value "$cursorSystemPath\msblue_pin.cur" -Force
$null = New-ItemProperty $regKeyCursor -Name 'SizeAll' -Value "$cursorSystemPath\msblue_move.cur" -Force
$null = New-ItemProperty $regKeyCursor -Name 'SizeNESW' -Value "$cursorSystemPath\msblue_nesw.cur" -Force
$null = New-ItemProperty $regKeyCursor -Name 'SizeNS' -Value "$cursorSystemPath\msblue_ns.cur" -Force
$null = New-ItemProperty $regKeyCursor -Name 'SizeNWSE' -Value "$cursorSystemPath\msblue_nwse.cur" -Force
$null = New-ItemProperty $regKeyCursor -Name 'SizeWE' -Value "$cursorSystemPath\msblue_ew.cur" -Force
$null = New-ItemProperty $regKeyCursor -Name 'UpArrow' -Value "$cursorSystemPath\msblue_up.cur" -Force
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
