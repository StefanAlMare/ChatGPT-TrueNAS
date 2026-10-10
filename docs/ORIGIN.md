# Why this exists, and how we got here / De ce există și cum am ajuns aici

[Home / Acasă](../README.md) · [Română](../README.ro.md) · [Routes / Trasee](ROUTES.md) · [History RC by RC](../HISTORY.md)

## The first problem / Problema inițială

**EN:** The owner routinely works with large diagnostic ZIPs, system logs, source snapshots and packages. Re-uploading entire objects into ChatGPT each time duplicates bytes and can consume per-file or account/project upload/storage allowances. The original aim was **ease of file handoff without requiring repeated full uploads**: store the bytes under the user's control; send exact identity and fetch only the content required by the AI. Model tokens, connector limits and tool calls still apply. Owner storage is **used**, not magically eliminated.

**RO:** Autorul lucrează cu arhive ZIP, loguri, pachete și surse mari. Reîncărcarea lor integrală la fiecare conversație dublează fișierele și poate consuma cotele ChatGPT de upload/stocare. Scopul a fost **predarea simplă a fișierelor, fără încărcări integrale repetate**: datele stau în stocarea proprie; asistentul primește identificatorul exact și citește numai fragmentele utile. Token-urile, apelurile uneltelor și limitele conectorilor rămân. Spațiul NAS **este folosit**.

## How the decisions evolved / Succesiunea deciziilor

| Step / Pas | Practical discovery / Ce am constatat | Result / De ce am ales soluția |
| --- | --- | --- |
| **1. Existing “drop”/cloud integrations** | Various file-drop, cloud and application/connector routes were explored. The owner recalls one “Drop…” option working in Work/Codex but not ordinary Chat. Its precise product name and exact test result are **not independently preserved**; do not present it as a confirmed Dropbox test. / Au fost explorate integrări „drop”/cloud; numele exact nu este confirmat în evidențele păstrate. | **Transfer capability is not the same as ChatGPT content-read capability.** / Transportul nu garantează citirea din Chat. |
| **2. Direct local file handoff** | Prototype used a Desktop drop folder, then native Finder Quick Action and a hidden queue. / Prototipul folosea Desktop; apoi Finder Quick Action și coadă ascunsă. | One action, frozen batches and exact clipboard paths. / Un singur gest, loturi fixe, căi exacte. |
| **3. SMB to TrueNAS** | Private LAN SMB can write reliably to the owner's storage. / SMB în LAN permite transfer către NAS propriu. | Keep original bytes in `ChatGPT-Live`, validate destination BYTES + SHA256, resume on failure. / Stocăm și verificăm la destinație, cu reluare. |
| **4. Outside the LAN** | SMB direct might be unreachable away from home/network. Public HTTP/Funnel/zrok experiments were not accepted as the stable product route. / SMB nu este mereu accesibil din exterior; rutele publice testate nu au rămas în produs. | Embed **private Tailscale/tsnet** as another path to **the same SMB destination**, with per-device enrollment. / Tailscale privat integrat, tot spre SMB. |
| **5. TrueNAS Reader** | Files on NAS are not visible automatically to cloud ChatGPT. A read-only MCP Reader through a secure central tunnel can inspect ZIP members and text/binary chunks. / ChatGPT cloud nu vede singur fișierele NAS; Reader/MCP poate citi membri/fragmente. | Separate **storage** from **AI reading**. / Separăm stocarea de citire. |
| **6. Chat vs Work/Projects differences** | Reader tool availability varies between conversation surfaces; some sessions could not invoke MCP despite working file transport. / Unele conversații nu aveau instrumentele Reader. | Keep a **Google Drive mirror** `ChatGPT Project Bridge` as a read fallback, via TrueNAS Cloud Sync `PUSH + SYNC`. No second Mac upload. / Oglindă Drive drept rezervă de citire, nu al doilea upload de pe Mac. |
| **7. Large-file and mirror-delay failures** | Drive may find a batch through direct folder listing before global search; large ZIP download can hit connector limits/413. / Drive indexează târziu și poate refuza arhive mari. | Reader ZIP member inspection first; direct Drive traversal and retry instruction; full transfer only as last resort. / Analiză la sursă, traversare directă. |
| **8. Seven-day cleanup** | Batches are working copies, not permanent backups. / Loturile sunt copii temporare, nu arhivă permanentă. | At 168 hours, TrueNAS deletes eligible batches and `PUSH + SYNC` propagates deletion. Verified first deployment: **31 batch directories** and sync SUCCESS on 8 October 2026. / Curățare 168h, prima execuție verificată. |
| **9. General product** | Not every user owns TrueNAS. / Nu fiecare utilizator deține TrueNAS. | Design profiles for ordinary SMB NAS, local disk and removable drive, each with separate Reader and retention. **Not yet fully implemented/validated.** / Profiluri viitoare, fără a pretinde suport final. |

## Product lessons / Lecții de proiectare

- **Upload ≠ read ≠ retention.** Each has its own setup, credentials, health checks and failure modes.
- **READY ≠ content analysis completed.** ChatGPT still needs authorized Reader/Drive tools.
- **Source reading ≠ zero tokens or zero storage.** NAS/Drive store the objects; only selected text enters model context.
- **Privacy is architectural:** private SMB/Tailscale; read-only root-confined MCP Reader; Keychain credentials; no public universal enrollment keys.
- **Public access ≠ open-source license.** Free official binaries, private proprietary sources, separate commercial exploitation rights.

## Historical acceptance / Ce a fost confirmat

Prototype and RC1-era work began in early September 2026; successive RC2–RC13 candidates solved Finder integration, installer permissions, runtime reliability, dual-network upload, credentials and Reader/Drive access. **RC13 is the accepted internal macOS baseline.** **RC14 V8** introduces a storage abstraction and enhanced handoff protocol; its native build/signature audit passed and the sanitized derivative was publicly released on 8 October. This is historical acceptance, not RC15.1 E2E evidence.

The precise RC-by-RC engineering narrative is in [HISTORY.md](../HISTORY.md). Private Git commits/logs remain private and must not be copied into a public repository.

On 10 October, removing Homebrew exposed runtime portability requirements and an RC15 GUI/installer Keychain-account mismatch. [RC15.1](https://github.com/StefanAlMare/ChatGPT-TrueNAS/releases/tag/v0.9.0-rc15.1) corrects identity and startup verification, retains sanitization and external-Python discovery, and passes isolated repair tests plus Apple notarization. Real administrative Update and transfer acceptance remain separate. / RC15.1 repară identitatea și verificarea pornirii; testele izolate și notarizarea nu înlocuiesc Update-ul real și transferul E2E.
