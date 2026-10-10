# Current release / Release curent — RC15.1

**[Download / Descarcă 0.9.0-rc15.1 — Update & Keychain Fix](https://github.com/StefanAlMare/ChatGPT-TrueNAS/releases/tag/v0.9.0-rc15.1)**

Intel x86_64 · build 16 · **NOTARIZED PREVIEW / PRE-RELEASE, NOT STABLE**.

| Field / Câmp | Verified value / Valoare verificată |
| --- | --- |
| Filename | `ChatGPT-Drop-Installer-macOS-x86_64-0.9.0-rc15.1-UPDATE-KEYCHAIN-FIX-PREVIEW-NOTARIZED.dmg` |
| Size / Dimensiune | `23051823` bytes / octeți |
| SHA-256 | `ddd457567e63320621f61475559e2434d0434918c250d0c50a410dfb3e948074` |
| Native environment / Mediu nativ | Intel macOS 26.7.1; MacPorts CPython 3.14.8 |
| Distribution checks / Verificări distribuție | Apple Accepted for payload, installer, DMG; stapling, strict signature, Gatekeeper and image integrity PASS |
| Repair tests / Teste reparație | 10 startup + 8 lifecycle/rollback + 2 stale-evidence isolated cases PASS; fixture credentials |
| Pending / Rămase | Real administrative Update, reboot and candidate transfer E2E; official Python/Homebrew and other-platform native tests |
| Terms / Drepturi | Existing proprietary non-commercial preview license; third-party rights preserved |

Read the **[complete bilingual release notes](../releases/v0.9.0-rc15.1.md)** for the defect, repair, test boundaries and notarization submission IDs. [Machine-readable manifest](../release-manifest.json) · [Sanitized validation summary](../releases/v0.9.0-rc15.1-validation.json) · [Installation](INSTALLATION.md) · [Python compatibility](COMPATIBILITY.md).

No Homebrew dependency is required, but an external standard CPython 3.14 is required: **there is no standalone embedded Python**. MacPorts was tested natively; python.org/Homebrew discovery is retained without new native certification. Notarization does not prove universal installation or NAS compatibility.

Nu este necesar Homebrew, dar este necesar CPython standard 3.14 extern. MacPorts a fost testat nativ; Python oficial/Homebrew rămân de validat nativ. Notarizarea nu certifică orice calculator sau NAS. Instalația funcțională, Keychain, profilele, jurnalele și backupurile existente nu au fost modificate de reparație.

## Historical public release / Release public istoric

**[RC14 V8 SANITIZED](https://github.com/StefanAlMare/ChatGPT-TrueNAS/releases/tag/v0.9.0-rc14)** remains available unchanged: `ChatGPT-Drop-Installer-macOS-x86_64-0.9.0-rc14-SANITIZED.dmg`, 23,093,113 bytes, SHA-256 `acfa658ee6e9408d18ceb20e6f2ef51a5e807660d5b9ec977b9623a3db39a8c6`. Its historical full Update/E2E and notarization were not confirmed. See [original release notes](../releases/v0.9.0-rc14.md) and [history](../HISTORY.md). The original private-configured RC14 DMG was not published; RC15.1 continues the sanitized release lineage. The superseded local RC15 DMG is not this release and was not overwritten.

[License](../LICENSE.md) · [Third-party notices](../THIRD_PARTY_NOTICES.md) · [Rights](RIGHTS.md) · [Status](STATUS.md)
