$ErrorActionPreference = "Stop"
$root = "C:\CX"
$iso = "$root\payload\Win11_23H2_ENT.iso"
$state = "$root\state"
$log = "$root\logs"

if (!(Test-Path "$state\PRECHECK_OK.txt")) {
    powershell -File "$root\payload\scripts\precheck.ps1"
}

Mount-DiskImage -ImagePath $iso
$drive = (Get-DiskImage -ImagePath $iso | Get-Volume).DriveLetter

$setup = "$drive`:\setup.exe"

Start-Process $setup -ArgumentList `
"/auto upgrade /quiet /noreboot /dynamicupdate disable /compat ignorewarning /copylogs $log" `
-Wait

Dismount-DiskImage -ImagePath $iso

Restart-Computer -Force
