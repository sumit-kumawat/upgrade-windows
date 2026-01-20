# CX – Offline Windows 10 to Windows 11 Upgrade Framework

## Document Classification
Internal Use – Enterprise / Defense Environment  
Air-Gapped, Offline, Volume License Compliant

---

## 1. Purpose

The **CX Upgrade Framework** provides a **safe, automated, offline, zero-login** mechanism to upgrade **Windows 10 Enterprise/Pro systems to Windows 11 Enterprise** using an **in-place upgrade** methodology.

This solution is designed for:
- Army / Defense / Government environments
- Air-gapped networks
- Volume-licensed systems
- Systems with unknown domain, NAS, or network dependencies

---

## 2. Key Guarantees

✔ No data loss  
✔ No application loss  
✔ No configuration loss  
✔ No user login required  
✔ No Internet connectivity required  
✔ No Active Directory dependency  
✔ No NAS dependency  
✔ Fully reversible (automatic rollback)  
✔ Volume License compliant  

---

## 3. Supported Scenarios

This framework works for:
- Domain-joined systems
- Standalone / workgroup systems
- Offline systems
- Systems with mapped drives or NAS usage
- Systems with BitLocker enabled
- Systems without network connectivity

---

## 4. Deployment Method

### Upgrade Type
**In-Place Upgrade (Mandatory)**

The following are explicitly NOT performed:
- No OS re-installation
- No disk formatting
- No image deployment
- No reset or wipe

---

## 5. Folder Structure (MANDATORY)

The folder name **CX** defines the business identity and must not be changed.
