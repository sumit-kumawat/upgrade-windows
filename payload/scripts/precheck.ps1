$ErrorActionPreference = "Stop"
$state = "C:\CX\state"
$log = "C:\CX\logs\precheck.log"
New-Item -ItemType Directory -Force -Path $state,$log | Out-Null

function Fail($msg) {
    $msg | Out-File "$state\FAILED.txt"
    exit 1
}

# OS Check
$os = (Get-CimInstance Win32_OperatingSystem).Caption
if ($os -notmatch "Windows 10") { Fail "Not Windows 10" }

# Disk Space
$disk = Get-PSDrive C
if ($disk.Free -lt 70GB) { Fail "Insufficient Disk Space" }

# TPM
$tpm = Get-WmiObject -Namespace root\cimv2\security\microsofttpm Win32_Tpm -ErrorAction SilentlyContinue
if (!$tpm -or !$tpm.IsEnabled().IsEnabled) { Fail "TPM not ready" }

# Secure Boot
if (!(Confirm-SecureBootUEFI)) { Fail "Secure Boot Disabled" }

# BitLocker Suspend
$bl = Get-BitLockerVolume -MountPoint C:
if ($bl.ProtectionStatus -eq "On") {
    Suspend-BitLocker -MountPoint C: -RebootCount 2
}

"PRECHECK_OK" | Out-File "$state\PRECHECK_OK.txt"
exit 0
