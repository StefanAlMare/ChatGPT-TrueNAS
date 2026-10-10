# Development history / Istoricul dezvoltării

## 10 October 2026 · RC15.1 Update & Keychain Fix

**EN:** RC15 portability work retained discovery of external standard CPython 3.14 from MacPorts, official Python and Homebrew without requiring Homebrew. Native MacPorts 3.14.8 checks passed. The subsequent Update failure was traced to a hardcoded Swift Keychain account `user`, inconsistent with installer/core configuration. RC15.1 removes that mismatch, adds current-session startup evidence and distinct failure outcomes, and strengthens credential preflight/LaunchAgent rollback. Transfer logic and RC14 sanitization are preserved. **20 isolated cases PASS** with fixture credentials; Apple notarization **Accepted** for payload, installer and DMG, with stapling/signatures/Gatekeeper PASS. The working app, real Keychain, profile, journals and backups were not changed. No real administrative Update, reboot or candidate transfer E2E was performed. **[New notarized prerelease](https://github.com/StefanAlMare/ChatGPT-TrueNAS/releases/tag/v0.9.0-rc15.1)**, build 16, 23051823 bytes, SHA-256 `ddd457567e63320621f61475559e2434d0434918c250d0c50a410dfb3e948074`. RC14 public release remains unchanged; the prior local RC15 DMG was not overwritten.

**RO:** După eliminarea Homebrew am păstrat detectarea CPython standard 3.14 extern din MacPorts/Python oficial/Homebrew. MacPorts 3.14.8 a fost testat nativ. Eșecul Update RC15 provenea din contul Swift fix `user`, diferit de contul configurat în installer/motor. RC15.1 unifică identitatea, verifică pornirea pe sesiune și întărește preflight-ul/rollback-ul fără modificarea transferului. 20 cazuri izolate PASS, notarizare Apple Accepted pentru toate cele trei artefacte. Instalația funcțională și datele protejate rămân intacte; Update real/reboot/E2E și Python oficial/Homebrew sunt încă de validat nativ. Publicarea documentației și a release-ului a fost autorizată separat de titular; nu s-a utilizat CI.

Historical entries below describe their dates, not the current release. / Intrările următoare sunt istorice.

This is an edited public technical chronology, grounded in the private development records. It preserves outcomes and limits without publishing source, private operational logs, personal file names, credentials or the private Git history. “Source ready”, “built”, “installed” and “end-to-end accepted” are different milestones.

Acesta este un istoric tehnic public redactat pe baza înregistrărilor private. Păstrează rezultatele și limitele, fără surse, loguri operaționale private, nume de fișiere personale, credențiale sau istoricul Git privat. Pregătirea sursei, build-ul, instalarea și acceptarea completă sunt etape distincte.

## 3–4 September 2026 · Foundation / Fundament## Origin and decision chain / De la idee la produs

**EN:** Before the numbered RCs, the owner wanted easy sharing of large diagnostics with ChatGPT **without repeatedly consuming the ChatGPT file-upload/storage allowance**. Existing cloud/drop-style integrations and public transport experiments showed that **moving bytes** and **letting a particular Chat/Work session read those bytes** are not the same. The exact early “Drop…” service name is not reliably documented, so this history does not invent a verified Dropbox test. The product separated (1) Mac→NAS transfer (SMB, then embedded private Tailscale when SMB was unreachable), (2) NAS→AI reading (read-only MCP Reader, then Drive mirror fallback when the active Chat/Project/Work lacked Reader tools), and (3) independent 168-hour cleanup. Content read for analysis still consumes tokens and connector resources; the original bytes still occupy NAS/Drive capacity.

**RO:** Ideea inițială: predarea simplă a arhivelor/logurilor mari către ChatGPT **fără încărcări integrale repetate care consumă cotele de upload/stocare**. Experimentele cu soluții de tip „Drop…”, cu transporturi publice și cu mediile Chat/Work au arătat că **transferul** nu garantează **citirea în conversație**. Numele exact al primei aplicații terțe nu este confirmat în istoricul salvat. Soluția a separat (1) transferul Mac→NAS prin SMB/Tailscale privat, (2) citirea NAS→ChatGPT prin Reader/MCP sau Google Drive și (3) ștergerea batch-urilor la 168h. Analiza consumă în continuare token-uri; fișierele ocupă spațiu pe NAS/Drive.

[Why / De ce](docs/ORIGIN.md) · [Route diagrams / Scheme](docs/ROUTES.md) · [Handover / Predare](docs/HANDOVER.md)

## 3–4 September 2026 · Foundation / Fundament

**EN:** The first project and cross-platform batch agent were created on 3 September. The prototype watched a Desktop drop folder, classified files, uploaded through SMB, verified destination size/SHA and produced a clipboard handoff. Transaction hardening, OS credential storage, path confinement and symlink rejection in the read-only TrueNAS Reader followed. Early macOS fixes addressed virtual-environment interpreter selection and SMB missing-file handling; a real multi-file batch established the first accepted core.

On 4 September, persistent color states and a native macOS menu-bar interface were added. Actual ChatGPT Reader metadata and text-content reads were recorded separately. Desktop wrappers and packaging preparation began for Windows/Ubuntu, together with a native macOS app shell, process-safe migration and a shared branded icon. Packaged macOS build/install and fresh-batch results were recorded. These steps did not establish native Windows or Ubuntu acceptance.

**RO:** Pe 3 septembrie apar proiectul și agentul pentru loturi. Prototipul urmărea un folder de pe Desktop, clasifica și transfera prin SMB, verifica octeții/SHA și genera mesajul din clipboard. Au urmat jurnalizarea tranzacțională, stocarea parolelor în serviciile sistemului și izolarea Reader-ului exclusiv pentru citire. Remedierile inițiale macOS au vizat interpretorul mediului virtual și tratarea fișierelor SMB absente; un lot real cu mai multe fișiere a confirmat motorul inițial.

Pe 4 septembrie sunt adăugate stările persistente și interfața din bara de meniu. Citirea metadatelor și citirea textului prin Reader/ChatGPT au dovezi distincte. Încep pregătirile Windows/Ubuntu, împachetarea macOS, actualizarea sigură a proceselor și iconul comun. Validarea macOS nu a validat automat celelalte platforme.

## Early candidate / RC1-era

**EN:** The records contain a branded macOS release-candidate phase before RC2. They do not establish a separately pinned and independently accepted “RC1” release artifact. This history therefore records the early candidate without inventing an RC1 download, checksum or validation result.

**RO:** Există o etapă de candidat macOS cu identitatea vizuală înainte de RC2. Nu este stabilit un artifact „RC1” separat, fixat și acceptat independent. Nu inventăm o descărcare, un checksum sau un rezultat RC1.

## 8 September · Reader scaling and remote experiments

**EN:** Large-file chunk tools and server-side ZIP member inspection were added and exercised. A roughly 723 MB ZIP was inspected through an isolated MCP path; later evidence distinguished production Reader promotion from actual tool availability in individual ChatGPT conversations. Ordinary ChatGPT Reader use worked in recorded tests, while some project/developer-mode conversations lacked invokable tools.

Funnel, bounded HTTPS read links and zrok variants were investigated. Some transport health checks passed, but actual ChatGPT reachability, runtime environment and service constraints prevented treating them as a dependable product route. Public ingress was retired; private Tailscale remained. These experiments are not current installation recommendations.

**RO:** Sunt dezvoltate citirea pe fragmente și inspectarea ZIP pe server. Un ZIP de aproximativ 723 MB a fost inspectat printr-o rută MCP izolată. Promovarea Reader-ului și disponibilitatea efectivă a uneltelor într-o anumită conversație ChatGPT au fost urmărite separat. Au existat teste reușite în conversații obișnuite și medii fără unelte invocabile.

Au fost investigate Funnel, linkuri HTTPS limitate și variante zrok. Unele verificări de transport au reușit, dar accesul real ChatGPT și constrângerile de runtime/serviciu au împiedicat acceptarea unei rute de produs fiabile. Accesul public a fost retras; Tailscale privat a rămas.

## Numbered candidates / Candidații numerotați

| Stage and date | Change / Modificare | Recorded outcome / Rezultat consemnat |
| --- | --- | --- |
| **RC2 · 8 Sep** | Reader-aware clipboard, ZIP/chunk instructions and Copy Last regeneration / Clipboard pentru Reader, ZIP și fragmente; refacerea ultimului mesaj | Source ready; initial native build blocked by missing Developer ID identity / Sursă pregătită; build inițial blocat de identitatea Developer ID absentă |
| **RC3 · before RC4** | Intermediate candidate / Candidat intermediar | Explicitly abandoned; no accepted artifact claimed / Abandonat explicit; nu este declarat artifact acceptat |
| **RC4 · 9 Sep** | Complete signed-DMG definition, UTF-8, real Quit, process-safe install/update/uninstall / Definiție DMG complet, UTF-8, Quit real și operații sigure | Source/package readiness recorded; not a blanket native acceptance / Pregătirea pachetului este consemnată, fără acceptare nativă generală |
| **RC5 · 9 Sep** | One visible graphical Installer app with Install/Update/Uninstall / Un singur installer grafic vizibil | Source/package ready; native validation remained a separate gate / Pachet pregătit; validarea nativă era separată |
| **RC6 · 9 Sep** | Finder Services, hidden queue and `ChatGPT-Live` / Servicii Finder, coadă ascunsă și rădăcina activă | Native build/sign PASS; update/uninstall failed on administrator authorization / Build și semnare PASS; actualizare/dezinstalare blocate de autorizare |
| **RC7 · 9 Sep** | Administrator-aware helpers retaining the real GUI user's state / Operații autorizate cu păstrarea contextului utilizatorului | Fix and build gates prepared; no separate final E2E acceptance claimed / Remediere și verificări pregătite, fără acceptare finală E2E separată |
| **RC8 · 9 Sep** | Pinned authoritative Finder installer and regression gates / Installer Finder autoritativ și verificări de regresie | Build/install/uninstall worked; update hit LaunchAgent bootstrap failure; Services was not a real Quick Action / Build, instalare și dezinstalare reușite; Update și Quick Action necesitau remedieri |
| **RC9 · 9 Sep** | Actual Finder Quick Action and update bootstrap fix / Quick Action real și remedierea Update | Build/install/update/uninstall PASS; action visible, but queue/runtime handoff failed / Operații installer PASS; acțiune vizibilă, dar predarea către runtime a eșuat |
| **RC10 · 9 Sep** | Accept arguments and stdin in Quick Action, atomic queue copies and diagnostics / Intrări prin argumente/stdin, copiere atomică și diagnostic | Handoff fix prepared; later diagnosis identified failing/restarting frozen core / Remediere pregătită; ulterior s-a identificat runtime-ul înghețat care eșua/repornea |
| **RC11 · 9 Sep** | Return to venv/Python runtime; PyInstaller disabled / Revenire la runtime Python în mediu virtual | iMac Update, Quick Action and fresh READY/clipboard observed; provisional pending final matrix / Rezultate observate pe iMac, acceptare încă provizorie |
| **RC12 · 9 Sep** | Adaptive LAN/private-client SMB, Drive read fallback and retention preparation / SMB adaptiv, rezervă Drive și pregătirea retenției | LAN/READY/category mirror accepted; small-content reads worked; tested Drive raw-download cap affected large ZIPs; remote-client visibility and TTL remained pending / LAN și oglindire acceptate; limite Drive, vizibilitatea clientului și TTL rămâneau de rezolvat |
| **RC13 · 9 Sep** | Embedded signed tsnet, private loopback SMB and Keychain enrollment; single installer / tsnet integrat semnat, SMB prin loopback și înrolare Keychain | Native helper/SMB gates passed, followed by user-validated off-LAN hotspot transfer and Drive content read; **internal macOS baseline accepted and closed** / Verificări native și test real din afara LAN acceptate; **versiune internă macOS acceptată și închisă** |
| **RC14 · 12 Sep** | SMB StorageBackend abstraction plus FIND + ANALYZE clipboard protocol / Abstracție SMB și protocol de descoperire/analiză | V8 native build/signing/outer audit PASS; **graphical Update and real RC14 E2E still unvalidated** / V8 build/semnare/audit PASS; **Update și E2E RC14 încă nevalidate** |

## RC13 transport refinement / Evoluția transportului RC13

**EN:** The first embedded-tsnet build stopped at a missing dependency lock file. The corrected helper built and signed successfully; enrollment and private TCP/445 were proven. An initial loopback SMB probe timed out. Peer diagnostics and bounded same-process retry then produced real SMB session/stat/list success. Integration added lifecycle hardening and native credential handling. The decisive user test removed the normal LAN route and transferred a batch using phone tethering; actual mirrored text content was then read through Drive because Reader tools were unavailable in that conversation.

**RO:** Primul build tsnet s-a oprit la lipsa fișierului de blocare a dependențelor. Helperul corectat a trecut build-ul, semnarea, înrolarea și TCP/445 privat. După un timeout inițial loopback, diagnosticul peer-ului și reluarea limitată în același proces au confirmat operații SMB reale. Integrarea a întărit ciclul de viață și gestionarea credențialelor. Testul decisiv a eliminat ruta LAN, a transferat prin hotspotul telefonului și a citit conținut text din oglinda Drive.

## Storage adaptation · 9–10 September

**EN:** A new track separated storage backend, Reader route and retention executor. Local folders, removable drives and generic SMB NAS profiles were proposed. The first implementation step introduced a backend contract wrapping the existing SMB engine. **No local-folder or external-volume adapter was implemented.** This successor work did not revoke RC13 acceptance.

**RO:** O etapă nouă a separat stocarea, citirea și retenția. Au fost propuse profiluri locale, externe și NAS SMB generic. Primul pas a abstractizat motorul SMB existent. **Adaptoarele locale și pentru disc extern nu au fost implementate.** Acceptarea RC13 a rămas valabilă.

## RC14 V1–V8 · 12 September

| Revision | Outcome / Rezultat |
| --- | --- |
| Initial / V1 | Combined StorageBackend and initial FIND/ANALYZE builder prepared / Pregătirea builderului combinat |
| V2 | Native meta-transform failure / Eșec al transformării native a builderului |
| V3 | Corrected wrapper still failed final audit transformation / Wrapper corectat, dar auditul final a eșuat |
| V4 | Further audit-anchor correction still failed in the meta layer / Altă corecție a auditului, încă eșec în stratul meta |
| V5 | Independent outer-DMG audit architecture; native build and audit PASS / Audit independent al DMG-ului final, build și audit PASS |
| V6 | Proposed 6/8/10-minute Drive grace after measured mirror lag; superseded before native execution / Așteptare Drive propusă, înlocuită înainte de rulare nativă |
| V7 | Immediate lookup, 30-second retry and 900-second timeout applied; stopped at a case-sensitive parity literal / Protocol imediat aplicat, blocat de un literal sensibil la majuscule |
| **V8** | Aligned that literal; native build, signatures, source parity, packaged immediate-retry markers and outer-DMG audit PASS / Literal aliniat; build, semnături, paritate și audit PASS |

At the 12 September checkpoint the latest candidate was `0.9.0-rc14`, build `14`; V8 identifies the build-recipe revision, not an app version `0.9.0-rc14.8`. RC13 remains the accepted rollback reference until RC14 Update and E2E pass. RC14 is retained as a historical public release after RC15.1 publication.

La checkpoint-ul din 12 septembrie candidatul era `0.9.0-rc14`, build `14`; V8 identifică revizia rețetei, nu o versiune a aplicației `0.9.0-rc14.8`. RC13 rămâne reperul acceptat până la validarea Update și E2E RC14. RC14 este păstrat ca release public istoric după publicarea RC15.1.

## Public publication audit · 8 October 2026

The supplied batch located the exact V8 DMG. Its local size and SHA-256 match the recorded artifact, and read-only image/signature checks passed. Inspection also found the proprietary Python runtime source inside the installer. Public distribution therefore requires resolution of the owner's no-source-publication constraint; artifact identity does not itself authorize source disclosure. See [the current release record](docs/RELEASE.md).

Lotul furnizat a permis recuperarea DMG-ului V8 exact. Octeții și SHA-256 coincid, iar verificările imaginii și semnăturilor au reușit. Auditul a identificat și sursa Python proprietară în installer. Distribuirea publică necesită rezolvarea cerinței autorului de a nu publica sursele; identitatea corectă a artifactului nu autorizează singură divulgarea lor.
