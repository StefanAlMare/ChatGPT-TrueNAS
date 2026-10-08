# Roadmap

**Goal:** avoid repeated whole-file uploads into ChatGPT while storing bytes under user control; preserve proprietary source and distribution rights. [Origin](ORIGIN.md) · [Routes](ROUTES.md) · [Rights/security](RIGHTS.md).

## New workstream — Universal Installer

**First implementation target:** macOS + TrueNAS, preserving accepted RC13 behavior. [Step-by-step user journey (RO)](UNIVERSAL_INSTALLER.ro.md) · [English](UNIVERSAL_INSTALLER.md) · [Server/storage deployment](HOSTING_AND_STORAGE.md) · [Security baseline](SECURITY_INSTALLER.md) · [Wizard state-machine and backend contract](WIZARD_CONTRACT.md) · [Native test gates](ACCEPTANCE_INSTALLER.md).

Milestones: M0 documentation/security foundation → M1 macOS/TrueNAS profile and safe SMB setup → M2 secure Reader/MCP deployment → M3 generic NAS and Linux hosts → M4 local/removable storage → M5 Drive/WebDAV/S3 direct adapters → M6 Windows/Ubuntu native clients → M7 universal distribution after validation. **M0 is documented; M1–M7 are not yet certified implementations.**

Priorities are ordered, not release-date commitments. / Prioritățile sunt ordonate, fără promisiuni de date.

| Priority | English | Română | Completion evidence / Dovadă |
| --- | --- | --- | --- |
| 1 | **COMPLETED:** published [sanitized proprietary RC14 V8 prerelease](https://github.com/StefanAlMare/ChatGPT-TrueNAS/releases/tag/v0.9.0-rc14); follow-up: generalized safe, configurable distribution | **REALIZAT:** primul pre-release RC14 V8 curățat și verificat; urmează installer universal configurabil | GitHub public asset `v0.9.0-rc14`, matching SHA-256 `acfa658ee6e9408d18ceb20e6f2ef51a5e807660d5b9ec977b9623a3db39a8c6`; source access and commercial use remain restricted |
| 2 | Complete RC14 V8 native Update and E2E acceptance | Validarea nativă Update și E2E RC14 V8 | State preserved; real verified batch; actual content read; regression matrix / Stare păstrată, lot verificat, conținut citit, regresii |
| 3 | General deployment provisioning | Configurare pentru instalări independente | No private deployment assumptions; host/share/account/peer setup tested / Fără presupuneri private; configurare testată |
| 4 | Implement local-folder backend | Implementarea backend-ului local | Same journal, atomic write, byte/SHA and READY semantics; native E2E / Aceleași garanții, test nativ |
| 5 | Implement external-volume backend | Implementarea backend-ului extern | Stable volume identity, unplug/replug and safe resume tests / Identitate stabilă, reconectare și reluare sigură |
| 6 | Named storage profiles and wizard | Profiluri de stocare și asistent | Create/edit/test/switch profiles; one active destination; credentials in Keychain / Gestionare/testare/schimbare, destinație unică, Keychain |
| 7 | Broaden generic SMB NAS compatibility | Extinderea compatibilității NAS SMB | Device-specific atomicity, interruption, verification and Reader tests / Teste pe dispozitiv pentru operații, întreruperi și citire |
| 8 | Separate Reader packaging for local/generic NAS | Pachet Reader pentru local/NAS generic | Root confinement, supported content routes and accessible authenticated connector / Izolare și acces autentificat validate |
| 9 | Monitor and broaden retention executors | Monitorizarea și extinderea retenției | Reference TrueNAS initial deletion **31 expired batches** and Drive Cloud Sync **SUCCESS** on 8 Oct 2026; future automatic runs and separate local/external safe-offline implementations still pending / Curățare și sincronizare inițială PASS; monitorizare și suport local/extern rămase |
| 10 | Native Windows and Ubuntu acceptance | Acceptarea nativă Windows și Ubuntu | Native install/update/uninstall, credentials and full-batch/content tests / Teste native complete |
| 11 | Evaluate Apple Silicon and supported macOS matrix | Evaluarea Apple Silicon și versiunilor macOS | Native platform results, documented runtime requirements and distribution checks / Rezultate native și cerințe documentate |
| 12 | Universal distribution package | Pachet de distribuție pentru toate platformele | All native platform gates, per-installer checksums and manifests / Validări complete, checksum-uri și manifeste |

Commercial/OEM or hosted-service arrangements remain a separate future track. A third-party code license is distinct from any hosted-service agreement. Free **non-commercial** preview use is the owner's current policy; business/commercial use requires written authorization. This does not complete future platform tracks.

Aranjamentele comerciale/OEM sau pentru servicii găzduite sunt o etapă viitoare separată. Licența codului terț nu înlocuiește acordul pentru serviciul găzduit. Utilizarea **necomercială** gratuită a versiunii oficiale este politica actuală; folosirea comercială cere acord scris și nu înseamnă finalizarea etapelor viitoare.
