# CX – Offline Windows 10 to Windows 11 Upgrade Framework

## Document Classification
Internal / Restricted – Defense & Government Use  
Air-Gapped • Offline • Volume License Compliant

---

## 1. Purpose
The **CX Upgrade Framework** automates an in-place upgrade from **Windows 10 Pro/Enterprise** to **Windows 11 Enterprise** without user login, internet, domain, or NAS dependencies.  

**Key Guarantees:**
- Preserves all user data, apps, and configurations
- Requires no user interaction
- Fully reversible with automatic rollback
- Volume License compliant
- Logs and status for audit

---

## 2. Supported Systems
**Supported:**
- Windows 10 Pro / Enterprise (x64)
- Domain-joined or standalone
- Offline, air-gapped environments
- BitLocker enabled (auto-suspended)

**Unsupported:**
- Windows Home editions
- Systems without TPM 2.0 or Secure Boot
- Retail (non-volume license) ISO

---

## 3. Folder & Naming Standards (MANDATORY)
**Folder name `CX` is required. Do NOT rename.**
C:\CX
├── install_task.cmd
├── uninstall_task.cmd
├── payload
│ ├── Win11_23H2_ENT.iso
│ └── scripts
│ ├── precheck.ps1
│ ├── upgrade.ps1
│ ├── postcheck.ps1
│ └── rollback.ps1
├── logs
└── state

ISO must be at: `C:\CX\payload\Win11_23H2_ENT.iso`.

---

## 4. Prerequisites
**Hardware:**
- TPM 2.0 enabled
- Secure Boot enabled
- ≥70 GB free on C:
- AC power connected

**Software:**
- Windows 10 Pro/Enterprise (Volume License)
- No pending reboots

**Media:**
- Official Windows 11 Enterprise Volume License ISO
- Must be offline and verified
- Retail ISO strictly prohibited

---

## 5. Pre-Execution Checklist
- [ ] ISO present at `C:\CX\payload\Win11_23H2_ENT.iso`
- [ ] Disk free space ≥ 70 GB
- [ ] System idle or safe for maintenance
- [ ] Power is stable
- [ ] Logs folder exists (`C:\CX\logs`)
- [ ] State folder exists (`C:\CX\state`)

---

## 6. Installation Steps (One-Time)
1. Copy the **CX** folder to `C:\CX`.
2. Open **Command Prompt as Administrator** and run:
C:\CX\install_task.cmd

This creates a scheduled task named `CX-Win11-Upgrade`.  
**No upgrade runs yet.**

---

## 7. Upgrade Execution (Zero Login)
Reboot the system:
shutdown /r /t 0

- Upgrade runs automatically under `NT AUTHORITY\SYSTEM`.
- No user login required.

---

## 8. Execution Flow
Boot
↓
Scheduled SYSTEM Task
↓
precheck.ps1
↓
If SAFE → setup.exe upgrade
↓
Automatic Reboot(s)
↓
postcheck.ps1
↓
Task self-deletion


---

## 9. Post-Upgrade Validation
**Check OS Version:**
winver

Expected: Windows 11 Enterprise

**Status Files (`C:\CX\state`):**
- `PRECHECK_OK.txt` — readiness checks passed
- `SUCCESS.txt` — upgrade completed
- `ROLLBACK.txt` — rollback occurred

**BitLocker Status:**
manage-bde -status

Protection should be ON

---

## 10. Rollback Behavior
- Automatic if upgrade fails
- No data, apps, or configs lost
- Logs preserved for audit
- Rollback window: 10 days (Windows default)

---

## 11. Emergency / Abort
If upgrade must be stopped **before reboot**:
C:\CX\uninstall_task.cmd

Removes scheduled task before it runs.

---

## 12. DOs
✔ Use Volume License ISO only  
✔ Ensure stable power  
✔ Keep CX folder intact  
✔ Allow automatic reboots  
✔ Collect logs after upgrade  
✔ Pilot rollout before mass deployment

---

## 13. DON’Ts
❌ Do not rename CX folder  
❌ Do not use Retail ISO  
❌ Do not connect to Internet during upgrade  
❌ Do not login during upgrade  
❌ Do not force shutdown during setup  
❌ Do not modify scripts without approval

---

## 14. Compliance & Security
- No outbound network calls  
- No credentials required  
- No domain or activation changes  
- Fully compliant with defense and enterprise deployment standards

---

## 15. Verification Commands
Check task removed:
schtasks /query | findstr CX

Check upgrade logs:
dir C:\CX\logs

Check OS version:
winver


---

## 16. Support & Troubleshooting
- Confirm ISO path & integrity
- Review `C:\CX\state` and `C:\CX\logs`
- Verify hardware prerequisites
- Retry in pilot environment if failure occurs

---

## 17. Ownership
Framework Name: **CX Upgrade Framework**  
Execution Context: SYSTEM  
Deployment Type: Offline / Air-Gapped  
Upgrade Method: In-Place

---

## 18. End of Document
