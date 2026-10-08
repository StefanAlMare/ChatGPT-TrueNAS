# Installation and use / Instalare și utilizare


**Start here / Începe aici:** [Why this exists](ORIGIN.md) · [Three data routes](ROUTES.md) · [Setup checklist for TrueNAS, generic NAS and drives](SETUP.md) · [Chat/Work handover](HANDOVER.md) · [Proprietary code and public release gates](RIGHTS.md).

## English

### Before you begin

**There is no public installer at this publication date.** These instructions explain the recorded installer workflow and deployment requirements; they are not a claim that a new user can complete installation from this repository today. It contains documentation only, with no source bootstrap, server image or build recipe.

The exact RC14 V8 candidate is Intel x86_64. Intel native build evidence exists; Apple Silicon native/universal compatibility and a general minimum macOS support matrix are not established. macOS 15.7.9 appears in earlier Intel installer tests; this is historical evidence, not a guaranteed RC14 minimum or full support matrix. No notarization acceptance result is established by the signing PASS markers alone.

The candidate derives from an internal deployment with fixed destination/provisioning assumptions. A public multi-profile wizard is not implemented. **Do not assume that changing an SMB password configures an arbitrary host, share, account or private peer.** A maintainer-adapted package and native validation are needed for a different deployment. No private endpoint values are reproduced here.

### Prepare a TrueNAS destination

1. Create or choose a dedicated dataset and SMB share for managed batches. Plan capacity and backups separately from the application's verification checks.
2. Give a dedicated SMB account the read/write, create and rename permissions needed inside the managed tree. Keep unrelated data outside that tree.
3. Agree the server, share, account, private peer and root mapping with the maintainer for the supplied package. The active logical root is **`ChatGPT-Live`**. Old prototype references to `ChatGPT-Inbox` are historical.
4. Confirm SMB is reachable on the LAN/private route. For off-LAN use, configure the NAS-side private Tailscale peer and access policy for the user's tailnet. The Mac-side embedded node must be enrolled for that user/installation.
5. Choose a read route: an authorized central Reader/MCP deployment or a category-preserving Drive mirror. Upload can work while ChatGPT reading remains unavailable; validate both independently.

TrueNAS Reader deployment requires a separately provided authorized server package. Conceptually, mount only the managed tree read-only into the Reader, align its service identity with read-only dataset ACLs, keep the container filesystem read-only, and connect a single central secure MCP tunnel. Configure `CHATGPT_INBOX_ROOT` to the service's mounted root; the legacy environment-variable name does not require the obsolete `ChatGPT-Inbox` storage layout. The Reader endpoint uses streamable HTTP at `/mcp`, internally on port 8000 in the recorded setup. No public server image, credentials or turnkey Compose deployment is supplied here.

### Install or update the Mac application, when the exact DMG is available

1. Obtain the official DMG and compare both its size and SHA-256 with [RELEASE.md](RELEASE.md). A matching filename alone is insufficient.
2. Open it and launch **ChatGPT Drop Installer.app**. The graphical installer is the intended visible DMG entry point. Do not follow old `.command`-based RC4 instructions for RC14.
3. Choose **Install** for a clean installation or **Update** for an existing installation, then authorize macOS when prompted. The expected application location is `/Applications/ChatGPT Drop.app`.
4. Confirm the menu-bar app launches. On update, check that configuration, state and credentials survive. **This exact RC14 V8 Update sequence is still unvalidated.**
5. Use **Configure SMB credential…** to store the password in Keychain for the package's agreed account. Never paste it into an issue or ChatGPT message.
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

3. Confirm the expected category/date/batch path exists on the NAS. For RC14 acceptance, independently verify destination bytes and SHA-256 and the exact clipboard controls.
4. Paste the prepared message into ChatGPT with the authorized Reader or Drive connector available. Require an actual content read. READY alone does not demonstrate Reader access.
5. Use **Copy batch message again** / Copy Last to restore the last completed handoff. **Quit ChatGPT Drop** stops the current session's application/core; Start at Login is a separate next-login preference. The brief Finder/Automator task spinner is not upload progress.

The hidden staging queue is `~/Library/Application Support/chatgpt-drop/inbox`; the user workflow is Finder selection, not the obsolete visible Desktop drop folder. User state is under `~/Library/Application Support/chatgpt-drop`, and logs under `~/Library/Logs/chatgpt-drop`. Treat config, journals, clipboard messages and logs as private. Uninstall is expected to preserve user state/logs and Keychain credentials for non-destructive reinstallation; it is not a privacy wipe. RC14-specific installer behavior still requires validation.

### Ordinary SMB NAS

The SMB storage adapter makes a generic NAS a plausible target, but there is no independent compatibility test or public setup wizard. Before support can be claimed, an adapted package must validate SMB authentication, create/read/rename operations, destination bytes/SHA, interrupted transfer recovery, and READY/clipboard behavior against that device. A NAS unable to host Reader needs a separately accessible Reader host or supported mirror. TrueNAS acceptance is not evidence that every SMB implementation behaves identically.

### Local Mac storage and external drives

**Not implemented in RC14 V8.** There is no working “This Mac” or “External Drive” backend to select. The hidden local queue is staging, not a local-storage destination mode. Do not treat an SMB-path workaround or a planned wizard screen as implemented support.

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

**La data publicării nu există installer public.** Ghidul descrie pașii înregistrați și cerințele; nu susține că un utilizator nou poate instala acum exclusiv din acest repository. Nu sunt furnizate surse, imagine Reader sau rețetă de build.

Candidatul RC14 V8 este Intel x86_64. Compatibilitatea nativă Apple Silicon/universal și matricea completă de versiuni macOS nu sunt stabilite. Testele Intel anterioare menționează macOS 15.7.9, fără a garanta un minim RC14. Semnarea reușită nu dovedește singură acceptarea notarizării.

Pachetul provine dintr-o instalare internă cu presupuneri fixe despre destinație și înrolare. Meniul parolei SMB nu configurează orice server, share, cont sau peer. O altă instalare necesită pachet adaptat de autor și validare nativă.

Pe TrueNAS pregătești un dataset și un share dedicate, capacitate și backup, plus un cont SMB cu drepturi în arborele administrat. Stabilești cu autorul corespondența server/share/cont/peer/rădăcină. Rădăcina logică activă este **`ChatGPT-Live`**; `ChatGPT-Inbox` aparține prototipului. Pentru acces din afara LAN sunt necesare peer-ul privat al NAS-ului, politica tailnet și înrolarea fiecărei instalări Mac.

Citirea prin ChatGPT se configurează separat: Reader/MCP central sau oglindă Drive care păstrează categoriile. Reader necesită un pachet autorizat separat, acces exclusiv de citire la arborele administrat, identitate de serviciu compatibilă cu ACL-urile și un singur tunel MCP central. Variabila istorică `CHATGPT_INBOX_ROOT` indică rădăcina montată în serviciu, fără a impune structura veche. Endpoint-ul înregistrat este `/mcp`, streamable HTTP, pe portul intern 8000. Aici nu este distribuită o implementare instalabilă a serverului.

### Instalare și utilizare când DMG-ul exact devine disponibil

1. Verifici octeții și SHA-256 conform [RELEASE.md](RELEASE.md), apoi deschizi **ChatGPT Drop Installer.app** din DMG.
2. Alegi **Install** sau **Update** și autorizezi macOS. Aplicația trebuie să ajungă în `/Applications/ChatGPT Drop.app`. Instrucțiunile vechi cu `.command` nu reprezintă interfața RC14.
3. Confirmi lansarea în bara de meniu și păstrarea stării/configurației/parolelor la actualizare. **Această secvență exactă RC14 V8 rămâne nevalidată.**
4. Salvezi parola în Keychain prin **Configure SMB credential…**, pentru contul stabilit cu autorul. Pentru acces privat folosești **Configure Tailscale…** cu înrolarea propriului tailnet; nu este furnizată o cheie universală. Arhitectura RC13 nu cere o aplicație Tailscale separată pe Mac.
5. Alegi **Start at Login** dacă dorești. Trimiți din Finder un fișier text mic, fără date sensibile, prin **Quick Actions → Send to ChatGPT Drop**.
6. Urmărești stările: gri = inactiv; galben = stabilizare; albastru = transfer/verificare; verde = lot verificat și clipboard pregătit; roșu = eroare/reluare, copiile păstrate.
7. Confirmi calea, octeții și SHA pe NAS, apoi lipești mesajul în ChatGPT cu Reader sau Drive disponibil și ceri citirea conținutului. READY nu dovedește accesul la Reader.

**Copy batch message again** / Copy Last reface mesajul ultimului lot. **Quit ChatGPT Drop** oprește sesiunea curentă; **Start at Login** controlează separat pornirea la următoarea autentificare. Indicatorul scurt Finder/Automator nu reprezintă progresul transferului.

Coada ascunsă este `~/Library/Application Support/chatgpt-drop/inbox`, starea este în `~/Library/Application Support/chatgpt-drop`, iar logurile în `~/Library/Logs/chatgpt-drop`. Originalele Finder nu sunt mutate. Configurația, jurnalele și mesajele de lot pot conține date private. Dezinstalarea este proiectată să păstreze starea, logurile și credențialele Keychain; nu reprezintă ștergerea tuturor datelor personale.

### NAS obișnuit, stocare locală și limite

Un NAS SMB obișnuit necesită adaptare și teste proprii de autentificare, scriere/citire/redenumire, SHA, întrerupere/reluare și READY. Nu există validare pentru toate dispozitivele SMB sau asistent public complet. Dacă NAS-ul nu poate găzdui Reader, este necesară o gazdă Reader accesibilă separat ori o oglindă compatibilă.

**Folderul local și discul extern nu sunt implementate în RC14 V8.** Coada locală nu este mod de stocare locală. Profilurile viitoare vor necesita selecția folderului/volumului, operații atomice verificate, rută de citire și retenție; deconectarea discului trebuie tratată fără pierderea jurnalului.

La erori de transfer păstrezi coada și jurnalul. Dacă Reader lipsește, activezi/reîmprospătezi uneltele sau folosești oglinda Drive configurată. Pentru fișiere proaspete se aplică traversarea directă la 30 de secunde, maximum 900 de secunde. Arhivele mari necesită citire pe membri când descărcarea integrală nu este disponibilă. Retenția la 168 de ore **a fost instalată și verificată pe TrueNAS-ul de referință la 8 octombrie 2026**: Cron ID 6, 31 de directoare expirate șterse, Cloud Sync PUSH+SYNC SUCCESS. Pe alt NAS trebuie configurată și verificată separat; scriptul privat nu este distribuit aici.
