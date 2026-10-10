# Installation and use / Instalare și utilizare


**Universal Installer work in progress / Proiectare installer universal:** [full RO step-by-step](UNIVERSAL_INSTALLER.ro.md) · [EN guide](UNIVERSAL_INSTALLER.md) · [storage/server choices](HOSTING_AND_STORAGE.md) · [security requirements](SECURITY_INSTALLER.md). RC15.1 fixes startup; it does not implement this future universal wizard.

**Start here / Începe aici:** [Why this exists](ORIGIN.md) · [Three data routes](ROUTES.md) · [Setup checklist for TrueNAS, generic NAS and drives](SETUP.md) · [Chat/Work handover](HANDOVER.md) · [Proprietary code and public release gates](RIGHTS.md).

## English

### Before you begin

**[Download RC15.1 — Update & Keychain Fix](https://github.com/StefanAlMare/ChatGPT-TrueNAS/releases/tag/v0.9.0-rc15.1)**, a notarized proprietary non-commercial preview. File: `ChatGPT-Drop-Installer-macOS-x86_64-0.9.0-rc15.1-UPDATE-KEYCHAIN-FIX-PREVIEW-NOTARIZED.dmg`; **23051823 bytes**; SHA-256 `ddd457567e63320621f61475559e2434d0434918c250d0c50a410dfb3e948074`. Compare against [the release record](RELEASE.md).

**Intel x86_64; external standard CPython 3.14 required.** No Homebrew dependency and no standalone Python bundled. MacPorts 3.14.8 passed native tests on macOS 26.7.1. Official python.org/Homebrew discovery is retained but not natively retested; keep the chosen Python installed. Declared macOS minimum is 15, without fresh native macOS 15 validation. System Python is not modified. [Full compatibility matrix](COMPATIBILITY.md).

The package preserves RC14 sanitization and reads the existing deployment configuration. It does not provide a general host/share/account/peer wizard. Configure a valid NAS profile separately with the maintainer before use; changing only a password does not configure a destination. Reader/MCP and retention remain separate server deployments.

### Prepare a TrueNAS destination

1. Create or choose a dedicated dataset and SMB share for managed batches. Plan capacity and backups separately from the application's verification checks.
2. Give a dedicated SMB account the read/write, create and rename permissions needed inside the managed tree. Keep unrelated data outside that tree.
3. Agree the server, share, account, private peer and root mapping with the maintainer for the supplied package. The active logical root is **`ChatGPT-Live`**. Old prototype references to `ChatGPT-Inbox` are historical.
4. Confirm SMB is reachable on the LAN/private route. For off-LAN use, configure the NAS-side private Tailscale peer and access policy for the user's tailnet. The Mac-side embedded node must be enrolled for that user/installation.
5. Choose a read route: an authorized central Reader/MCP deployment or a category-preserving Drive mirror. Upload can work while ChatGPT reading remains unavailable; validate both independently.

TrueNAS Reader deployment requires a separately provided authorized server package. Conceptually, mount only the managed tree read-only into the Reader, align its service identity with read-only dataset ACLs, keep the container filesystem read-only, and connect a single central secure MCP tunnel. Configure `CHATGPT_INBOX_ROOT` to the service's mounted root; the legacy environment-variable name does not require the obsolete `ChatGPT-Inbox` storage layout. The Reader endpoint uses streamable HTTP at `/mcp`, internally on port 8000 in the recorded setup. No public server image, credentials or turnkey Compose deployment is supplied here.

### Install or update the Mac application, on a test installation

1. Obtain the official DMG and compare both its size and SHA-256 with [RELEASE.md](RELEASE.md). A matching filename alone is insufficient.
2. Open it and launch **ChatGPT Drop Installer.app**. The graphical installer is the intended visible DMG entry point. Use the graphical installer, not historical `.command` instructions.
3. Choose **Install** for a clean installation or **Update** for an existing installation, then authorize macOS when prompted. The expected application location is `/Applications/ChatGPT Drop.app`.
4. Confirm the menu-bar app launches. On update, check that configuration, state and credentials survive. **Real administrative RC15.1 Update on the working installation is still untested.** Credential preflight runs before stopping the old app. Isolated rollback tests passed, including LaunchAgent restoration; this does not replace a controlled real Update test.
5. Use **Configure SMB credential…** to store the password in Keychain for the username in the existing configuration. No generic `user` credential is created automatically. A clean installation without credentials reports `WAITING_FOR_CONFIGURATION`, not a verified engine. Never paste it into an issue or ChatGPT message.
6. If private remote access is needed, use **Configure Tailscale…** with enrollment material for your own tailnet. No shared universal enrollment key is provided. The RC13 design needs no separate Mac Tailscale application or system VPN interface.
7. Set **Start at Login** if desired and perform the harmless first-use test below before relying on the candidate.

### Use and verify one harmless batch

1. In Finder, select a small non-sensitive text file. Choose **Quick Actions → Send to ChatGPT Drop**; Services is the legacy fallback. Enable the action in the macOS Finder/Quick Actions controls if it is hidden.
2. Watch the application's menu-bar state:

| Color | Meaning |
| --- | --- |
| Gray | Idle |
| Yellow | Waiting for stable input |
| Blue | Uploading or verifying |
| Green | Entire batch verified; clipboard ready |
| Red | Error/retry; staged originals retained |

3. Confirm the expected category/date/batch path exists on the NAS. For candidate acceptance, independently verify destination bytes and SHA-256 and the exact clipboard controls.
4. Paste the prepared message into ChatGPT with the authorized Reader or Drive connector available. Require an actual content read. READY alone does not demonstrate Reader access.
5. Use **Copy batch message again** / Copy Last to restore the last completed handoff. **Quit ChatGPT Drop** stops the current session's application/core; Start at Login is a separate next-login preference. The brief Finder/Automator task spinner is not upload progress.

The hidden staging queue is `~/Library/Application Support/chatgpt-drop/inbox`; the user workflow is Finder selection, not the obsolete visible Desktop drop folder. User state is under `~/Library/Application Support/chatgpt-drop`, and logs under `~/Library/Logs/chatgpt-drop`. Treat config, journals, clipboard messages and logs as private. Uninstall is expected to preserve user state/logs and Keychain credentials for non-destructive reinstallation; it is not a privacy wipe. Real administrative installer behavior still requires validation.

### Ordinary SMB NAS

The SMB storage adapter makes a generic NAS a plausible target, but there is no independent compatibility test or public setup wizard. Before support can be claimed, an adapted package must validate SMB authentication, create/read/rename operations, destination bytes/SHA, interrupted transfer recovery, and READY/clipboard behavior against that device. A NAS unable to host Reader needs a separately accessible Reader host or supported mirror. TrueNAS acceptance is not evidence that every SMB implementation behaves identically.

### Local Mac storage and external drives

**Not implemented in RC15.1.** There is no working “This Mac” or “External Drive” backend to select. The hidden local queue is staging, not a local-storage destination mode. Do not treat an SMB-path workaround or a planned wizard screen as implemented support.

The planned workflow is to select a managed folder or stable volume identity, verify write/read/atomic operations, configure a Reader/connector and choose retention. External-volume disappearance must pause safely and resume after reconnection. These need separate implementations and native tests before installation instructions can become operational. See [ROADMAP.md](ROADMAP.md).

### Troubleshooting and cleanup

- **No Quick Action:** check Finder action enablement and whether installer registration completed.
- **Red state:** check the agreed network/SMB route and credential; keep the queue and journal intact for retry.
- **Green but no tools:** enable/refresh the Reader tools in the receiving environment or use the configured Drive fallback.
- **Drive file missing:** traverse the exact hierarchy and follow the 30-second/900-second protocol; search alone is inconclusive.
- **Large archive cannot download:** use supported member-level Reader tools; historical Drive raw-object limits are not a transfer failure.
- **Retention:** the 168-hour cleaner was installed and initially validated on the reference TrueNAS on **8 October 2026** (Cron ID 6, 31 expired batch directories removed, Cloud Sync PUSH+SYNC job SUCCESS). The worker is still private/not distributed here; **other installations must configure and verify it separately**.

## Română

### Disponibilitate și pregătire

**[Descarcă RC15.1 — Update & Keychain Fix](https://github.com/StefanAlMare/ChatGPT-TrueNAS/releases/tag/v0.9.0-rc15.1)**: preview Intel x86_64 notarizat, gratuit pentru utilizare necomercială. Fișier `ChatGPT-Drop-Installer-macOS-x86_64-0.9.0-rc15.1-UPDATE-KEYCHAIN-FIX-PREVIEW-NOTARIZED.dmg`, **23051823 octeți**, SHA-256 `ddd457567e63320621f61475559e2434d0434918c250d0c50a410dfb3e948074`.

Este necesar **CPython standard 3.14 extern**. Nu depinde de Homebrew și nu include Python autonom. MacPorts 3.14.8 este testat nativ pe macOS 26.7.1; detectarea Python oficial/Homebrew este păstrată, fără teste native noi. Python-ul macOS nu este modificat. Minimul declarat macOS 15 rămâne de validat. Păstrează Python-ul ales instalat. [Compatibilitate completă](COMPATIBILITY.md).

Configurația existentă este citită fără cont SMB hardcodat. Pentru altă destinație stabilești separat server/share/cont/root/peer; meniul parolei nu este wizard universal. Reader și retenția se instalează separat.

Pe TrueNAS pregătești un dataset și un share dedicate, capacitate și backup, plus un cont SMB cu drepturi în arborele administrat. Stabilești cu autorul corespondența server/share/cont/peer/rădăcină. Rădăcina logică activă este **`ChatGPT-Live`**; `ChatGPT-Inbox` aparține prototipului. Pentru acces din afara LAN sunt necesare peer-ul privat al NAS-ului, politica tailnet și înrolarea fiecărei instalări Mac.

Citirea prin ChatGPT se configurează separat: Reader/MCP central sau oglindă Drive care păstrează categoriile. Reader necesită un pachet autorizat separat, acces exclusiv de citire la arborele administrat, identitate de serviciu compatibilă cu ACL-urile și un singur tunel MCP central. Variabila istorică `CHATGPT_INBOX_ROOT` indică rădăcina montată în serviciu, fără a impune structura veche. Endpoint-ul înregistrat este `/mcp`, streamable HTTP, pe portul intern 8000. Aici nu este distribuită o implementare instalabilă a serverului.

### Instalare și utilizare RC15.1 pe o instalare de test

1. Verifici octeții și SHA-256 conform [RELEASE.md](RELEASE.md), apoi deschizi **ChatGPT Drop Installer.app** din DMG.
2. Alegi **Install** sau **Update** și autorizezi macOS. Aplicația trebuie să ajungă în `/Applications/ChatGPT Drop.app`. Instrucțiunile vechi cu `.command` nu reprezintă interfața actuală.
3. Confirmi lansarea în bara de meniu și păstrarea stării/configurației/parolelor la actualizare. **Update-ul administrativ RC15.1 pe instalația funcțională nu a fost efectuat.** Preflight-ul verifică credentialul înainte de oprire. Rollback-ul a trecut teste izolate, inclusiv restaurarea LaunchAgent; testul real rămâne necesar.
4. Salvezi parola în Keychain prin **Configure SMB credential…**, pentru contul din configurație. Nu se creează automat un cont alternativ `user`. La instalare fără credential, `WAITING_FOR_CONFIGURATION` înseamnă că trebuie configurat; nu confirmă pornirea motorului. Pentru acces privat folosești **Configure Tailscale…** cu înrolarea propriului tailnet; nu este furnizată o cheie universală. Arhitectura RC13 nu cere o aplicație Tailscale separată pe Mac.
5. Alegi **Start at Login** dacă dorești. Trimiți din Finder un fișier text mic, fără date sensibile, prin **Quick Actions → Send to ChatGPT Drop**.
6. Urmărești stările: gri = inactiv; galben = stabilizare; albastru = transfer/verificare; verde = lot verificat și clipboard pregătit; roșu = eroare/reluare, copiile păstrate.
7. Confirmi calea, octeții și SHA pe NAS, apoi lipești mesajul în ChatGPT cu Reader sau Drive disponibil și ceri citirea conținutului. READY nu dovedește accesul la Reader.

**Copy batch message again** / Copy Last reface mesajul ultimului lot. **Quit ChatGPT Drop** oprește sesiunea curentă; **Start at Login** controlează separat pornirea la următoarea autentificare. Indicatorul scurt Finder/Automator nu reprezintă progresul transferului.

Coada ascunsă este `~/Library/Application Support/chatgpt-drop/inbox`, starea este în `~/Library/Application Support/chatgpt-drop`, iar logurile în `~/Library/Logs/chatgpt-drop`. Originalele Finder nu sunt mutate. Configurația, jurnalele și mesajele de lot pot conține date private. Dezinstalarea este proiectată să păstreze starea, logurile și credențialele Keychain; nu reprezintă ștergerea tuturor datelor personale.

### NAS obișnuit, stocare locală și limite

Un NAS SMB obișnuit necesită adaptare și teste proprii de autentificare, scriere/citire/redenumire, SHA, întrerupere/reluare și READY. Nu există validare pentru toate dispozitivele SMB sau asistent public complet. Dacă NAS-ul nu poate găzdui Reader, este necesară o gazdă Reader accesibilă separat ori o oglindă compatibilă.

**Folderul local și discul extern nu sunt implementate în RC15.1.** Coada locală nu este mod de stocare locală. Profilurile viitoare vor necesita selecția folderului/volumului, operații atomice verificate, rută de citire și retenție; deconectarea discului trebuie tratată fără pierderea jurnalului.

La erori de transfer păstrezi coada și jurnalul. Dacă Reader lipsește, activezi/reîmprospătezi uneltele sau folosești oglinda Drive configurată. Pentru fișiere proaspete se aplică traversarea directă la 30 de secunde, maximum 900 de secunde. Arhivele mari necesită citire pe membri când descărcarea integrală nu este disponibilă. Retenția la 168 de ore **a fost instalată și verificată pe TrueNAS-ul de referință la 8 octombrie 2026**: Cron ID 6, 31 de directoare expirate șterse, Cloud Sync PUSH+SYNC SUCCESS. Pe alt NAS trebuie configurată și verificată separat; scriptul privat nu este distribuit aici.

## Startup diagnostics / Diagnostic pornire

GUI launch, helper launch and Python engine readiness are separate. Fresh per-launch evidence must establish `CORE_VERIFIED`; an old log or process-name match is insufficient. `CREDENTIAL_NOT_FOUND` means the configured account lacks an accessible credential; `CORE_START_FAILED` means launch failed; `CORE_EXITED` means the engine ended; `CORE_START_TIMEOUT` means current readiness was not proven within the deadline. GUI failures have separate app statuses. Keep session logs private; do not create a generic credential to hide an identity mismatch.

Pornirea aplicației grafice, a helperului și a motorului Python sunt verificate separat. Păstrează logurile sesiunii și jurnalele pentru diagnostic. Nu șterge Keychain, profilele sau backupurile și nu ocoli Gatekeeper. Dacă macOS respinge pachetul, raportează versiunea și eroarea fără date private.
