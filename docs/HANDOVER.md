# Handover contract — Chat, Projects, Work and Codex / Predare către asistent

**Purpose / Scop:** a new conversation must understand exactly **why** ChatGPT Drop exists, how the files arrive, which connector to use, what has passed validation and what actions are prohibited.

## Read these five references first / Ordine de citire

1. [README](../README.md) / [Română](../README.ro.md): problem and current status.
2. [ORIGIN](ORIGIN.md): why SMB, Tailscale, Reader and Drive were chosen.
3. [ROUTES](ROUTES.md): the three distinct data paths.
4. [SETUP](SETUP.md): expected storage/Reader/retention configuration.
5. [RIGHTS](RIGHTS.md), [STATUS](STATUS.md) and [HISTORY](../HISTORY.md): disclosure boundaries, current acceptance and history.

For **authorized private development only**, read the authoritative `StefanAlMare/Private-Work/ChatGPT-Bridge/continuity/CHATGPT_DROP_PERMANENT_WORKING_RULES.md`, then `CHATGPT_DROP_MASTER_CONTINUITY.md` and its named checkpoint **before** any source change. Do not disclose private source, secrets or logs publicly. No GitHub edit on any branch without current explicit approval; **never edit protected `main`** or run GitHub CI/Actions without separate approval.

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
- Don't label a source patch/build **fully functional** without native install and E2E. Accepted macOS rollback: **RC13**; RC14 V8 only build/signature/DMG audited in authoritative records.
- When an action is destructive (cleanup, overwriting, public release, changing licensing), identify precise scope, create a controlled checklist and validate the result.
- Preserve originality: Finder source files, frozen batch journal, destination SHA, private keys, Keychain and read-only MCP boundary.
- **Never publish the current RC14 V8 DMG unchanged** as a “closed-source binary”: it bundles proprietary Python source and fails the stated source-privacy gate.
- Save material checkpoints in the private continuity registry **only after explicit authorization to write**, never assume permission for GitHub CI, `main`, or other repositories.

## C. Short handover paragraph / Mesaj gata de lipit

> Continue ChatGPT-TrueNAS / macOS ChatGPT Drop. **Goal:** avoid repeated full-file uploads into ChatGPT; bytes stay in owner-controlled storage and only needed content enters model context. Distinguish **upload** (Finder → SMB direct or embedded private Tailscale → NAS), **read** (read-only Reader/MCP preferred; Drive mirror direct traversal fallback) and **retention** (168h server cleaner, Drive PUSH+SYNC). Start with the public README, ORIGIN, ROUTES, SETUP, STATUS and RIGHTS. A READY batch proves verified upload, not that this Chat can access Reader. Match PATH/BYTES/SHA, inspect actual source content before answering, avoid whole ZIP transfer where member-level tools exist. **RC13** is accepted baseline; **RC14 V8** build/signature PASS but full install/E2E not yet accepted; no public installer because the existing DMG bundles proprietary source. Do not expose private code, secrets or user data. No edits to GitHub without fresh explicit permission, and never to protected main or CI.

[Why](ORIGIN.md) · [Routes](ROUTES.md) · [Security](RIGHTS.md)
