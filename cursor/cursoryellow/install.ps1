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
Copy-Item msyellow_*.ani C:\Windows\Cursors\ -Force -ErrorAction SilentlyContinue
Copy-Item msyellow_*.cur C:\Windows\Cursors\ -Force -ErrorAction SilentlyContinue

# create Yellow scheme
$0 = 'HKCU:\Control Panel\Cursors'
$p = '%SystemRoot%\cursors'

if (!(Test-Path "$0\Schemes")) { $null = New-Item -Path $0 -Name 'Schemes' -Force }
$null = New-ItemProperty -Path "$0\Schemes" -Force -Name 'MSYellow' -Value "$p\msyellow_arrow.cur,$p\msyellow_helpsel.cur,$p\msyellow_working.ani,$p\aero_busy.ani,,,$p\msyellow_pen.cur,$p\aero_unavail.cur,$p\msyellow_ns.cur,$p\msyellow_ew.cur,$p\msyellow_nwse.cur,$p\msyellow_nesw.cur,$p\msyellow_move.cur,$p\msyellow_up.cur,$p\msyellow_link.cur,$p\msyellow_pin.cur,$p\msyellow_person.cur"

# apply Yellow scheme
Set-Item $0 -Value 'MSYellow' -Force
$null = New-ItemProperty $0 -Name 'AppStarting' -Value "$p\msyellow_working.ani" -Force
$null = New-ItemProperty $0 -Name 'Arrow' -Value "$p\msyellow_arrow.cur" -Force
$null = New-ItemProperty $0 -Name 'Crosshair' -Value '' -Force
$null = New-ItemProperty $0 -Name 'Hand' -Value "$p\msyellow_link.cur" -Force
$null = New-ItemProperty $0 -Name 'Help' -Value "$p\msyellow_helpsel.cur" -Force
$null = New-ItemProperty $0 -Name 'IBeam' -Value '' -Force
$null = New-ItemProperty $0 -Name 'No' -Value "$p\aero_unavail.cur" -Force
$null = New-ItemProperty $0 -Name 'NWPen' -Value "$p\msyellow_pen.cur" -Force
$null = New-ItemProperty $0 -Name 'Person' -Value "$p\msyellow_person.cur" -Force
$null = New-ItemProperty $0 -Name 'Pin' -Value "$p\msyellow_pin.cur" -Force
$null = New-ItemProperty $0 -Name 'SizeAll' -Value "$p\msyellow_move.cur" -Force
$null = New-ItemProperty $0 -Name 'SizeNESW' -Value "$p\msyellow_nesw.cur" -Force
$null = New-ItemProperty $0 -Name 'SizeNS' -Value "$p\msyellow_ns.cur" -Force
$null = New-ItemProperty $0 -Name 'SizeNWSE' -Value "$p\msyellow_nwse.cur" -Force
$null = New-ItemProperty $0 -Name 'SizeWE' -Value "$p\msyellow_ew.cur" -Force
$null = New-ItemProperty $0 -Name 'UpArrow' -Value "$p\msyellow_up.cur" -Force
$null = New-ItemProperty $0 -Name 'Wait' -Value "$p\aero_busy.ani" -Force

# Scheme Source -- 0=Windows Default, 1=User Scheme, 2=System Scheme
$null = New-ItemProperty $0 -Name 'Scheme Source' -Value 1 -Type dword -Force

# reload system cursors
$cs = @'
[DllImport("user32.dll", SetLastError = true, EntryPoint = "SystemParametersInfo")]
[return: MarshalAs(UnmanagedType.Bool)]
public static extern bool SystemParametersInfo(uint uiAction, uint uiParam, bool pvParam, uint fWinIni);
'@
 
$SPI_SETCURSORS = 0x0057
$CursorRefresh = Add-Type -MemberDefinition $cs -Name WinAPICall -Namespace SystemParamInfo –PassThru
$CursorRefresh::SystemParametersInfo($SPI_SETCURSORS, 0, $null, 0)
