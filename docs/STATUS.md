# Feature and validation status / Stadiul funcționalităților

Reviewed / Revizuit: **2026-10-10**. Current public candidate / Candidat public curent: **[RC15.1 build 16](https://github.com/StefanAlMare/ChatGPT-TrueNAS/releases/tag/v0.9.0-rc15.1)**, notarized prerelease. Historical accepted internal baseline / Reper istoric acceptat: **RC13**. RC15.1 is not promoted to stable or complete E2E acceptance.

[Release notes](../releases/v0.9.0-rc15.1.md) · [Validation summary](../releases/v0.9.0-rc15.1-validation.json) · [Python compatibility](COMPATIBILITY.md) · [Installation](INSTALLATION.md) · [Rights](RIGHTS.md)

## RC15.1 repair evidence / Dovezi reparație

| Gate / Verificare | Observed result / Rezultat |
| --- | --- |
| Hardcoded Swift account in RC15 | Confirmed by binary inspection; removed in RC15.1 / Confirmat în binar; eliminat |
| Configured account identity | GUI, installer and Python use the same configuration username, no generic fallback / Aceeași identitate, fără cont alternativ |
| Native isolated startup | **10/10 PASS**, including delayed start, missing credentials, helper failure, early crashes and timeout |
| Isolated installer/rollback | **8/8 PASS**; real fixture file restoration, isolated administration/process control and mocked old-app relaunch |
| Old/wrong-session evidence | **2/2 PASS**; stale evidence cannot prove startup |
| Additional checks | Swift identity/outcome, sanitization, transfer-code parity and protected-file preservation **PASS** |
| Credential test boundary | Fixture backend with real configured account identity, fictitious password; real SMB password unused and unchanged |
| Signing/notarization | Apple **Accepted** for payload, installer, DMG; stapling, strict signatures, Gatekeeper, DMG integrity **PASS** |
| Native environment | Intel macOS 26.7.1; MacPorts CPython 3.14.8 |
| Installed production app | **Not updated**; configuration, journals, backups, profiles and Keychain preserved |

## Remaining acceptance / Validări rămase

1. Controlled real administrative Update and verified rollback, preserving actual state/Keychain; reboot and login behavior.
2. Harmless real batch over direct SMB and private embedded Tailscale; exact destination bytes/SHA, READY and clipboard.
3. Actual content reading via Reader/MCP or configured Drive mirror; interrupted-transfer retry, Copy Last and Quit regressions.
4. Native tests with official python.org/Homebrew CPython 3.14, declared macOS 15 minimum and additional Intel computers.
5. Independent support work for Apple Silicon, other OSes, generic NAS provisioning, universal wizard and local/external backends.

**Română:** testele izolate nu sunt Update administrativ pe instalația reală, reboot sau transfer E2E. Notarizarea confirmă verificarea distribuției, nu compatibilitatea cu orice calculator. MacPorts este testat; Python oficial/Homebrew sunt detectate, dar rămân de testat nativ. TrueNAS/Reader/retenția nu au fost modificate pentru reparație.

## Historical capabilities and limits / Funcții și limite istorice

The following RC12–RC14 and 8 October evidence is retained as history; it is not a fresh RC15.1 transfer or server test.

| Capability / Funcție | Evidence and actual limit / Dovezi și limită reală |
| --- | --- |
| Finder selection → hidden queue → READY | Accepted macOS lineage through RC13; RC14 regression test pending / Acceptat până la RC13; regresia RC14 de testat |
| Frozen journal, byte/SHA verification, retry/resume | Established core invariants preserved by RC14 source/package gates; real RC14 interrupted-transfer test not recorded / Invariante păstrate în verificările RC14; test real RC14 de întrerupere neconsemnat |
| Direct LAN SMB | RC12 accepted and RC13 baseline preserved / Acceptat RC12, păstrat RC13 |
| Embedded tsnet off-LAN SMB | RC13 real native SMB and user hotspot E2E accepted / SMB nativ și test hotspot RC13 acceptate |
| No separate Mac Tailscale client | RC13 embedded design and native evidence; per-installation enrollment and NAS peer still required / Confirmat RC13; înrolarea și peer-ul NAS rămân necesare |
| Status colors, READY and clipboard | Accepted lineage; green represents whole-batch verification, not Reader availability / Linie acceptată; verde nu confirmă disponibilitatea Reader |
| Copy Last, Quit, login preference | Present in accepted product contract; no independent complete RC14 regression matrix / Prezente; matricea completă RC14 lipsește |
| Reader read-only confinement | Implemented, with historical MCP metadata/text and ZIP/chunk tests / Implementat și testat istoric pentru metadate/text/ZIP/fragmente |
| Reader availability in every ChatGPT chat/project | Not guaranteed; actual tool exposure varies / Negarantată; depinde de uneltele expuse |
| Large ZIP analysis | Historical ~723 MB isolated Reader ZIP test; format/tool support and connector limits still apply / Test Reader istoric izolat; limitele formatelor/conectorilor rămân |
| Google Drive mirror and small-content reads | RC12/RC13 accepted; mirror lag observed; historical 256 MiB raw download limit in tested connector / Acceptate; întârziere observată și limită istorică a conectorului testat |
| Immediate lookup / 30-second retry / 900-second timeout | Markers present in exact V8 runtime, freshly inspected; execution on a real RC14 content batch unvalidated / Markeri confirmați acum; executarea pe un lot RC14 real nevalidată |
| SMB StorageBackend abstraction | In RC14 package/source parity; only SMB backend exists / Inclusă RC14; există numai SMB |
| Universal Installer / generic NAS wizard | **DESIGN DOCUMENTED only** in [Romanian user journey](UNIVERSAL_INSTALLER.ro.md), [hosting matrix](HOSTING_AND_STORAGE.md), [security model](SECURITY_INSTALLER.md) and [acceptance tests](ACCEPTANCE_INSTALLER.md); no general implementation/E2E validated / **DOAR PROIECTARE DOCUMENTATĂ**, fără implementare universală validată |
| Local folder and external-volume destination | **Not implemented** / **Neimplementate** |
| 168-hour TrueNAS retention | **Reference TrueNAS PASS, 8 Oct 2026:** cleaner/Cron ID 6 active; initial execution removed **31 expired batch directories**, Cloud Sync PUSH+SYNC ID 1 job finished **SUCCESS**, representative old files absent from NAS and Drive listings. Future automatic expiry cycles still to be observed / **PASS pe TrueNAS de referință, 8 oct.:** Cron activ, 31 loturi șterse, Cloud Sync SUCCESS; monitorizarea execuțiilor ulterioare rămâne |
| Configurable retention per storage profile | Roadmap / Planificat |
| Windows / Ubuntu | Packaging preparation only; native release validation pending / Pregătire pachete; validare nativă în așteptare |
| Apple Silicon native / universal macOS | Not established for this x86_64 candidate / Nestabilit pentru candidatul x86_64 |
| Universal three-platform distribution | Not released; gated on native acceptance on each platform / Nelansată; necesită acceptarea fiecărei platforme |
| RC14 graphical Update/state preservation/app launch | **Not yet validated** / **Încă nevalidate** |
| RC14 V8 DMG bytes/SHA, integrity and signatures | Fresh checks PASS on 8 October, without install / PASS reverificat la 8 octombrie, fără instalare |
| RC14 V8 public binary | **PUBLISHED as sanitized prerelease, 8 Oct 2026:** 23,093,113 bytes, SHA-256 `acfa658ee6e9408d18ceb20e6f2ef51a5e807660d5b9ec977b9623a3db39a8c6`; GitHub API digest and owner download check PASS. Private original never uploaded. / **PUBLICAT pre-release curățat**, hash verificat; originalul privat nu a fost publicat. Proprietary-source reuse/commercial use still requires written approval |
| Historical RC14 notarization | Not confirmed for RC14; RC15.1 notarization is verified separately below / Neconfirmată RC14; RC15.1 verificat separat |
