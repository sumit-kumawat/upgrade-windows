# CX – Offline Windows 10 to Windows 11 Upgrade Framework

## Document Classification
Internal / Restricted – Defense & Government Use  
Air-Gapped • Offline • Volume License Compliant  

---

## 1. Purpose

The **CX Upgrade Framework** provides a **safe, automated, offline, zero-login** method to upgrade **Windows 10 Enterprise/Pro systems to Windows 11 Enterprise** in production environments.  

It is designed for:
- Army / Defense / Government environments  
- Air-gapped networks  
- Volume-licensed systems  
- Systems with unknown domain, NAS, or network dependencies  

**Key Guarantees:**
- No data loss  
- No application loss  
- No configuration loss  
- Zero user login required  
- Fully reversible (automatic rollback)  
- Volume License compliant  

---

## 2. Supported Scenarios

- Domain-joined systems  
- Standalone / workgroup systems  
- Offline / air-gapped systems  
- Systems with mapped drives or NAS usage  
- Systems with BitLocker enabled  
- Systems without network connectivity  

**Not supported:**  
- Retail Windows editions  
- Windows Home  
- Systems without TPM 2.0 capability  

---

## 3. Folder & Naming Standards (MANDATORY)

**Folder name `CX` defines the business identity and must not be changed.**

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


❗ Renaming or moving files will prevent proper execution.

---

## 4. Pre-Deployment Prerequisites

### Hardware Requirements
- TPM 2.0 present and enabled  
- Secure Boot capable  
- Minimum 4 GB RAM (8 GB recommended)  
- Minimum 70 GB free disk space on C:  
- AC power connected  

### Software Requirements
- Windows 10 Pro or Enterprise (Volume Licensed)  
- BitLocker allowed (will be auto-suspended)  
- No pending reboots  

### Media Requirements
- Official **Windows 11 Enterprise Volume License ISO**  
- ISO must be offline and verified  
- Retail or consumer ISO is strictly prohibited  

---

## 5. Pre-Execution Checklist (Operator Must Verify)

- [ ] ISO present at `C:\CX\payload\Win11_23H2_ENT.iso`  
- [ ] Disk free space ≥ 70 GB  
- [ ] No pending reboots or system tasks  
- [ ] System is idle or safe for maintenance  
- [ ] Power source is stable  
- [ ] Backup policy verified  

---

## 6. Installation Procedure (One-Time Setup)

### Step 1 – Copy Framework
Copy the complete `CX` folder to:

C:\CX


### Step 2 – Install SYSTEM Startup Task
Open **Command Prompt as Administrator** and run:

C:\CX\install_task.cmd


Expected result:
- SYSTEM-level scheduled task `CX-Win11-Upgrade` is created  
- No upgrade is performed yet  

---

## 7. Upgrade Execution Procedure (Zero Login)

### Step 3 – Reboot System

shutdown /r /t 0


- Upgrade runs automatically under **NT AUTHORITY\SYSTEM**  
- No user login is required  

---

## 8. Execution Flow

Boot
↓
SYSTEM Scheduled Task
↓
Precheck (Hardware + Safety)
↓
If Safe → In-Place Upgrade
↓
Automatic Reboot(s)
↓
Post-Upgrade Validation
↓
Scheduled Task Self-Deletion


---

## 9. Post-Upgrade Validation

### Check OS Version

winver
Expected:
Windows 11 Enterprise

### Status Files
C:\CX\state

- `PRECHECK_OK.txt` → System passed readiness checks  
- `SUCCESS.txt` → Upgrade completed successfully  
- `ROLLBACK.txt` → Automatic rollback occurred  

### BitLocker Status
manage-bde -status

Protection should be **On**

---

## 10. Rollback Behavior

- Rollback occurs automatically if upgrade fails  
- No user action required  
- Data, apps, and configurations remain intact  
- Logs preserved for audit  

Rollback window: **10 days (default Windows behavior)**

---

## 11. Emergency Procedures

### Cancel Upgrade Before Reboot


C:\CX\uninstall_task.cmd


### Power Interruption Handling
- Windows Setup will resume or roll back automatically  
- No manual recovery required  

---

## 12. Logs & Audit

- Logs are stored in:


C:\CX\logs

- Status files in:


C:\CX\state

- Can be collected manually for audit purposes  

---

## 13. DOs (MANDATORY)

✔ Use **Volume License ISO** only  
✔ Ensure **stable power**  
✔ Keep **CX folder intact**  
✔ Allow **automatic reboots**  
✔ Collect logs post-upgrade  
✔ Use phased rollout for multiple systems  

---

## 14. DON’Ts (STRICTLY PROHIBITED)

❌ Do not rename the CX folder  
❌ Do not use Retail / OEM ISO  
❌ Do not connect to Internet  
❌ Do not login during upgrade  
❌ Do not force shutdown during setup  
❌ Do not modify scripts without authorization  

---

## 15. Compliance & Security Notes

- No outbound network calls  
- No credential usage  
- No domain modification  
- No activation changes  
- Fully compliant with Microsoft enterprise and defense deployment standards  

---

## 16. Verification Commands (Optional)

- Check OS version: `winver`  
- Check scheduled task: `schtasks /query | findstr CX`  
- Check BitLocker: `manage-bde -status`  

---

## 17. Ownership

Framework Name: **CX Upgrade Framework**  
Execution Context: SYSTEM  
Deployment Type: Offline / Air-Gapped  
Upgrade Method: In-Place  

---
## 18. End of Document
