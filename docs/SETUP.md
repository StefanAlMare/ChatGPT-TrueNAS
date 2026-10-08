# Setup: TrueNAS, ordinary NAS and personal drives / Configurare

**Current product boundary:** the proven deployment is macOS Intel → SMB/TrueNAS → Reader/MCP or Drive mirror. The owner has published **[the sanitized RC14 V8 prerelease](https://github.com/StefanAlMare/ChatGPT-TrueNAS/releases/tag/v0.9.0-rc14)** for non-commercial preview use; only the new `-SANITIZED.dmg` is public, with SHA-256 `acfa658ee6e9408d18ceb20e6f2ef51a5e807660d5b9ec977b9623a3db39a8c6`. Readable Python runtime remains proprietary and is not licensed for reuse. The repository still does not include a Reader container or general NAS configuration wizard; other deployments require adaptation/testing.

## A. TrueNAS reference checklist / Configurare TrueNAS

1. **Storage:** create a dedicated dataset/folder `ChatGPT-Live` within a chosen SMB share. Keep unrelated data and permanent backups **outside** it. Example NAS host path: `/mnt/<pool>/<dataset>/ChatGPT-Live`.
2. **SMB and account:** enable an authenticated SMB share. Give the ChatGPT Drop upload account only the create, read, rename and write permissions needed in that managed tree. Test from the Mac over the local/private network. Do not publish SMB/445 to the open internet.
3. **macOS ChatGPT Drop:** obtain an authorized compatible client build and configure its SMB host, share, root and account, with password in macOS Keychain. The existing RC14 candidate is **not** a generic setup wizard; do not reuse another person's hard-coded endpoint.
4. **Private remote upload (optional):** connect NAS and individual Mac installation to an authorized Tailscale tailnet. The embedded macOS tsnet node must enroll separately. Test direct SMB first; simulate an unavailable LAN path and verify private SMB/Tailscale with a harmless file. Never embed a reusable universal auth key.
5. **Reader:** run the authorized TrueNAS Reader centrally as a read-only service. Its source data mount must be `/mnt/<pool>/<dataset>/ChatGPT-Live:/data:ro`; the Reader's configured root should resolve to `/data`. Reader filesystem/container and service account should have no write capability into managed data. Verify `list_files`, `list_batch`, `file_info` and `zip_list` with actual data. The historical variable name `CHATGPT_INBOX_ROOT` may remain, but **must not** point to the retired `ChatGPT-Inbox` tree.
6. **ChatGPT connector:** connect the one central Reader to a compatible authenticated ChatGPT environment through its secure MCP tunnel. Reader tool availability varies by **Chat, Project, Work and Codex**; check it in the actual destination conversation. Do not equate “connected tunnel” with a usable tool in every Chat.
7. **Optional Google Drive fallback:** configure a dedicated `ChatGPT Project Bridge` folder and TrueNAS **Cloud Sync: PUSH + SYNC** with source `ChatGPT-Live`. Preserve the category/date/batch hierarchy. Verify a small file appears and can be read through an authorized Drive connector; Drive is a mirror, **not** the primary Mac upload target.
8. **Seven-day cleanup:** deploy the separate owner-approved retention worker through the supported TrueNAS Apps/CLI/API/Cron mechanisms. Use batch UTC timestamp + **168 hours**, limit deletion strictly to valid managed batch directories, and trigger the existing `PUSH + SYNC` job after deletions. Dry-run before first application. Verify a sample expired batch disappears on NAS, the Drive job reports `SUCCESS`, and the corresponding Drive file no longer appears. Reference deployment achieved this on **8 October 2026** (31 initial batches); the script itself is **not published as source here**.
9. **End-to-end acceptance:** from Finder submit a harmless batch, require remote BYTES/SHA verification and READY; paste the exact manifest into the destination Chat/Work and require **actual content reading** via Reader or Drive. Also test failure/retry and preserve original Finder files.

**Security boundary:** public documentation does not include real NAS IPs, SMB passwords, Tailscale credentials, API secrets, signed certificates or private user logs. Access controls and permitted remote use must be configured per owner.

## B. Ordinary SMB NAS / NAS obișnuit

A generic NAS may offer SMB storage even if it cannot run a Reader. It needs a writable managed root, SMB authentication, temporary-file+rename semantics, SHA verification, retry tests and one **separately reachable read route**. If it supports containers or apps, a compatible read-only Reader could run locally on the NAS; otherwise a trusted machine could host it while mounted read-only, or a suitable Drive mirror could act as fallback.

**This is a compatibility architecture, not a certified “works on every NAS” claim.** The current macOS build has reference-specific provisioning assumptions and no tested general NAS wizard.

## C. Local folder or removable drive / Drive local sau extern

Planned profiles: “This Mac” and “External Drive”. The intended implementation requires a storage adapter supporting atomic destination operations, journal/retry, volume identity and detach/reconnect handling, plus a **Reader/connector reachable by ChatGPT** and a suitable local retention worker. A cloud chat cannot automatically read an arbitrary disk merely because files exist there.

**Neither local-folder nor external-volume destination adapter is implemented in RC14 V8.** Its private macOS queue is not a local-storage product profile. Do not present this as ready to install.

## D. Operational quick checks / Verificări

| Check | Accept only when |
| --- | --- |
| Upload | File arrives in exact batch path with size/SHA equal to manifest |
| Reader | Real directory, metadata, ZIP-member and content reads succeed in the intended conversation |
| Drive fallback | Direct traversal finds exact batch; actual content readable, not just metadata |
| Retention | Cron is enabled; expired managed batch removed; corresponding Cloud Sync succeeds |
| Installer/release | Owner-authorized RC14 may expose proprietary runtime source (no reuse rights); **no secrets**, proper upstream notices, checksum/signing verified; RC14 E2E, notarization and generic NAS remain unverified |

[Routes and diagrams](ROUTES.md) · [Handover](HANDOVER.md) · [Security and acceptance gates](RIGHTS.md)
