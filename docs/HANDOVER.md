# Handover contract — Chat, Projects, Work and Codex / Predare către asistent

**Purpose / Scop:** a new conversation must understand exactly **why** ChatGPT Drop exists, how the files arrive, which connector to use, what has passed validation and what actions are prohibited.

**Universal Installer successor:** [user journey](UNIVERSAL_INSTALLER.ro.md), [hardware/storage deployments](HOSTING_AND_STORAGE.md), [security policy](SECURITY_INSTALLER.md), [implementation contract](WIZARD_CONTRACT.md), [acceptance tests](ACCEPTANCE_INSTALLER.md). At this stage these are SPECIFICATIONS, not validated new app features. Do not change the private baseline or claim installation/E2E results without native evidence.

## Read these five references first / Ordine de citire

1. [README](../README.md) / [Română](../README.ro.md): problem and current status.
2. [ORIGIN](ORIGIN.md): why SMB, Tailscale, Reader and Drive were chosen.
3. [ROUTES](ROUTES.md): the three distinct data paths.
4. [SETUP](SETUP.md): expected storage/Reader/retention configuration.
5. [RIGHTS](RIGHTS.md), [STATUS](STATUS.md) and [HISTORY](../HISTORY.md): disclosure boundaries, current acceptance and history.

For **authorized private development only**, read the authoritative `StefanAlMare/Private-Work/ChatGPT-Bridge/continuity/CHATGPT_DROP_PERMANENT_WORKING_RULES.md`, then `CHATGPT_DROP_MASTER_CONTINUITY.md` and its named checkpoint **before** any source change. Do not disclose private source, secrets or logs publicly. No GitHub edit on any branch without current explicit approval; respect branch protections and never run GitHub CI/Actions without separate approval. The owner explicitly authorized the RC15.1 public documentation/main and release update; that authorization does not extend to private repositories or CI.

## A. Receiving a batch / Analiza unui lot

Use this procedure only when the actual session exposes the necessary tools:

1. Read `BATCH`, `FILES_EXPECTED` and all `PATH | BYTES | SHA256` lines; don't conflate metadata with content.
2. Prefer `TrueNAS ChatGPT Reader` immediately: `list_batch` then `file_info`; for ZIP use `zip_list`/`zip_find`/`zip_member_info`/`zip_read_text_chunk`. Compare sizes and hashes. Read the members needed to answer, not the archive wholesale.
3. If Reader is missing/forbidden/returns a clear path error, switch to the connected **Google Drive**. Navigate `ChatGPT Project Bridge/<category>/<date>/<batch>` directly; for source paths beginning `ChatGPT-Live/` remove **only** that prefix. Identify filename plus BYTES, and SHA when exposed.
4. If the batch/child is not visible, follow requested `LOCATE_RETRY_SECONDS=30` / `LOCATE_TIMEOUT_SECONDS=900` when execution capability permits; re-list the exact folder. A global search is last-resort discovery, never proof of absence. Do **not** claim a background timer or indefinite automatic retries without a real scheduler.
5. Analyze actual **content** with bounded reads. Download the full binary only if neither source can inspect the required format, explaining the reason. A 413 does not prove corruption; it is usually a response-size/transport limit.
6. If unavailable after supported attempts, report the **precise missing layer**: MCP access, NAS root, Drive folder/date/batch/child, format reader, or time limit. Never invent contents or successful transfer.

### Example manifest (placeholder, not a real file)

```text
BATCH=<UTC-device-random-ID>
LOCATE_RETRY_SECONDS=30
LOCATE_TIMEOUT_SECONDS=900
FILES_EXPECTED=1
PATH=ChatGPT-Live/Arhive/<date>/<batch>/<file>.zip | BYTES=<size> | SHA256=<64-hex>
```

## B. Before changing the product / Înainte de modificări

- Determine the user's actual goal: troubleshoot upload, restore Reader, configure Drive, fix retention or build a new package. **These are separate subsystems.**
- Verify evidence from logs/connector/read-only server checks before changing config. Don't “repair” macOS Drop to address a server-side Reader mount or missing Cron.
- Don't label a source patch/build **fully functional** without native install and E2E. Accepted macOS rollback: **RC13**; RC15.1 has isolated startup/rollback tests and notarization PASS; real administrative Update, reboot and transfer E2E remain pending.
- When an action is destructive (cleanup, overwriting, public release, changing licensing), identify precise scope, create a controlled checklist and validate the result.
- Preserve originality: Finder source files, frozen batch journal, destination SHA, private keys, Keychain and read-only MCP boundary.
- **Owner-approved exception:** the **sanitized, signed and notarized RC15.1 preview**, continuing historical RC14 V8 SANITIZED, may be publicly distributed as a proprietary non-commercial preview. The original contains private NAS/SMB/Tailscale defaults and must not be distributed; bundled Python runtime may still be visible. This visibility is **not** permission for commercial use, code integration, redistribution or derivatives. Do not publish private development sources or any credentials.
- Save material checkpoints in the private continuity registry **only after explicit authorization to write**, never assume permission for GitHub CI, `main`, or other repositories.

## C. Short handover paragraph / Mesaj gata de lipit

> Continue ChatGPT-TrueNAS / macOS ChatGPT Drop. **Current public candidate: [RC15.1 build 16](https://github.com/StefanAlMare/ChatGPT-TrueNAS/releases/tag/v0.9.0-rc15.1)**, SHA-256 `ddd457567e63320621f61475559e2434d0434918c250d0c50a410dfb3e948074`, 23051823 bytes. It fixes the RC15 hardcoded `user` Keychain mismatch by reading the configured SMB account in GUI/installer/Python, without alternate credential creation or password changes. Startup is session-specific and distinguishes GUI/helper/Python/credential/crash/timeout; stale evidence is rejected. Twenty isolated cases passed with fixture credentials; Apple accepted app/installer/DMG, tickets/signatures/Gatekeeper passed. External standard CPython 3.14 required, no embedded interpreter or Homebrew dependency; MacPorts 3.14.8 tested on Intel macOS 26.7.1, official Python/Homebrew and declared macOS 15 minimum still need native tests. **Real administrative Update, reboot and candidate transfer E2E were not performed; working app and protected state remain untouched.** Historical RC13 remains the accepted internal baseline. Preserve RC14 sanitization, transfer logic, profiles, Keychain, journals and backups. Public repo contains docs and authorized sanitized binaries, not private development source/logs. Distinguish upload, read-only Reader/Drive access and 168h retention; READY proves upload, not AI content access. Future universal wizard/local/external backends are not implemented. This publication was explicitly owner-authorized; any later GitHub/private-repository write or CI needs authorization for that scope. Deliver future handovers **in full, in writing in the current chat** for the owner to transmit manually.


[Why](ORIGIN.md) · [Routes](ROUTES.md) · [Security](RIGHTS.md)
