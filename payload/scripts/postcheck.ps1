$state = "C:\CX\state"
$log = "C:\CX\logs"

$os = (Get-CimInstance Win32_OperatingSystem).Caption

if ($os -match "Windows 11") {
    Resume-BitLocker -MountPoint C:
    "SUCCESS" | Out-File "$state\SUCCESS.txt"
} else {
    "ROLLBACK" | Out-File "$state\ROLLBACK.txt"
}

schtasks /delete /tn "CX-Win11-Upgrade" /f
