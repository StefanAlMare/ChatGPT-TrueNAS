# ChatGPT-TrueNAS
### ChatGPT Drop · macOS client · Proprietary project

**Send files once. Keep the full bytes in storage you control. Let ChatGPT read only the relevant content.**

[Română](README.ro.md) · [Why we built it](docs/ORIGIN.md) · [Route diagrams](docs/ROUTES.md) · [Set up storage](docs/SETUP.md) · [Chat/Work handover](docs/HANDOVER.md) · [History](HISTORY.md) · [Rights and security](docs/RIGHTS.md) · [Credits](docs/CREDITS.md)



**[Download RC15.1 — Update & Keychain Fix, notarized preview →](https://github.com/StefanAlMare/ChatGPT-TrueNAS/releases/tag/v0.9.0-rc15.1)** — Intel macOS, privacy-sanitized, proprietary non-commercial preview.

**ChatGPT-TrueNAS** is the public documentation and distribution project. **ChatGPT Drop** is the Apple/macOS application's current name. This is an independent project, not an official OpenAI, Apple, GitHub, Tailscale or iXsystems product.

## Universal Installer (design phase)

A guided setup will cover official ChatGPT installation, ChatGPT Drop, TrueNAS, generic NAS and other storage, secure Reader/MCP access and retention. This **is not yet part of the RC15.1 app**.

[Full English guide](docs/UNIVERSAL_INSTALLER.md) · [Complete Romanian guide](docs/UNIVERSAL_INSTALLER.ro.md) · [Hardware and storage](docs/HOSTING_AND_STORAGE.md) · [Security](docs/SECURITY_INSTALLER.md) · [Technical contract](docs/WIZARD_CONTRACT.md) · [Acceptance tests](docs/ACCEPTANCE_INSTALLER.md)

## Why it exists

We started with a practical problem: repeatedly uploading ZIPs, logs, code snapshots and other large files into ChatGPT conversations uses file-upload/storage allowances and duplicates the same data. The project aims to **avoid consuming ChatGPT file-upload/storage quota unnecessarily**, not to avoid consuming tokens. The original bytes still occupy the owner's NAS (and, if enabled, the Drive mirror); content retrieved for analysis still consumes model context, tool calls and tokens. No “unlimited quota” claim is made.

We examined existing file-drop/cloud integrations and attempted ways to read NAS data inside ChatGPT. Some tools or connectors appeared in Work/Codex but not ordinary Chat/Projects. A useful file-transfer mechanism was **not automatically a usable ChatGPT read path**. This led to two independent routes: verified file delivery **to storage** and controlled content access **from storage to ChatGPT**. [Read the decision history](docs/ORIGIN.md).

## Three different mechanisms — not one tunnel

| Purpose | Primary | Fallback / lifecycle |
| --- | --- | --- |
| **1. Upload from Mac** | Finder Quick Action → ChatGPT Drop → direct SMB → owner-controlled NAS | Private embedded Tailscale/tsnet → the **same** NAS SMB service when direct SMB is unavailable; failed batches remain resumable |
| **2. Read in Chat/Work** | Read-only TrueNAS Reader through an authorized MCP connector; ZIP member/chunk inspection at source | Configured Google Drive `ChatGPT Project Bridge` mirror, direct category/date/batch traversal; full object transfer only as last resort |
| **3. Clean up** | Batch UTC timestamp + 168 hours → TrueNAS scheduled cleaner | TrueNAS Cloud Sync `PUSH + SYNC` propagates deletions to Drive; retain permanent backups **outside** the expiring batch tree |

**Tailscale solves the Mac → NAS transport**, not the cloud ChatGPT → NAS reading problem. A green **READY** status proves the batch was transferred and verified; it does **not** prove that the current Chat or Work session can read it.

### Data-flow map

```mermaid
flowchart TD
    F["Finder → ChatGPT Drop"] --> S{"SMB direct available?"}
    S -->|Yes| N["TrueNAS / NAS: ChatGPT-Live"]
    S -->|No| T["Embedded private Tailscale / tsnet"]
    T --> N
    N --> V["Verify BYTES + SHA-256 → READY"]
    N --> R{"Reader/MCP available in Chat or Work?"}
    R -->|Yes| M["Read-only Reader: ZIP members and chunks"]
    R -->|No| D["TrueNAS Cloud Sync → Google Drive mirror"]
    D --> P["Drive connector: category/date/batch"]
    M --> A["Relevant source content → ChatGPT"]
    P --> A
    N -.-> X["168h retention → delete batch"]
    X -.-> Y["PUSH + SYNC → propagate deletion to Drive"]
```

The three independently configured layers are **upload, content reading, and retention**. The detailed diagrams also show failure/retry and the rule against full-archive transfer by default.

[**View the three GitHub-rendered diagrams →**](docs/ROUTES.md)

## How to use the reference macOS workflow

1. Select files in Finder → **Quick Actions → Send to ChatGPT Drop**. Original files stay in place.
2. The app freezes a batch, copies to its private queue, uploads through the chosen private SMB path, uses temporary names, and validates destination **BYTES + SHA-256**. An incomplete transfer retains state for retry.
3. On success, it places **BATCH + PATH + BYTES + SHA256** in the clipboard.
4. Paste the message into Chat or Work **with Reader/MCP or Drive access enabled**. Prefer listing and reading source members/parts; do not copy a complete large ZIP into the conversation when source inspection works.
5. The server can automatically remove managed batches after **seven days**, independently from the Mac application.

[TrueNAS setup](docs/SETUP.md) · [Ordinary NAS and local-drive roadmap](docs/SETUP.md) · [Exact handover protocol for new Chat and Work](docs/HANDOVER.md)

## Current status · 10 October 2026

**RC15.1 fixes startup after Update:** the GUI now uses the configured SMB account, consistently with the installer and Python engine. Startup verification distinguishes the app, helper and engine using fresh evidence for each launch. It never automatically creates an alternative `user` credential.

| Area | Verified state |
| --- | --- |
| **Newest prerelease** | **[ChatGPT Drop 0.9.0-rc15.1 — Update & Keychain Fix](https://github.com/StefanAlMare/ChatGPT-TrueNAS/releases/tag/v0.9.0-rc15.1)**, build 16, Intel x86_64 |
| **Signing and notarization** | Developer ID; Apple **Accepted** for app, installer and DMG; tickets stapled and validated; Gatekeeper accepts all three |
| **Repair tests** | **20 isolated cases PASS:** 10 startup, 8 installation/rollback, 2 stale-evidence cases; fixture Keychain backend, no real SMB password |
| **Python** | No Homebrew dependency; external standard **CPython 3.14** required. MacPorts **3.14.8 tested natively**; official Python/Homebrew discovery retained, without fresh native tests of those distributions |
| **Still to validate** | Administrative Update on a real installation, reboot and full RC15.1 transfer; official Python/Homebrew, macOS 15 and other computers |
| **Existing installation** | Not updated during this repair; configuration, journals, backups and Keychain preserved |
| **TrueNAS Reader and retention** | Historical 8 October evidence: Reader working, 31 expired directories removed, Drive sync SUCCESS; not retested or modified for this release |
| **Other platforms and destinations** | Apple Silicon, Windows/Linux and generic NAS unvalidated; local/external backends and universal wizard unimplemented |

DMG: **23,051,823 bytes** · SHA-256: `ddd457567e63320621f61475559e2434d0434918c250d0c50a410dfb3e948074`.

[What changed and why](releases/v0.9.0-rc15.1.md) · [Installation](docs/INSTALLATION.md) · [Python compatibility](docs/COMPATIBILITY.md) · [Detailed status](docs/STATUS.md) · [Release identity](docs/RELEASE.md) · [Roadmap](docs/ROADMAP.md)

## Free to use is not open-source

**Official binaries may be used free of charge for personal, educational and other non-commercial purposes. Commercial/business use requires prior written approval**, as do repackaging, resale, redistribution, paid hosting, white-label/OEM integration and use of proprietary code in other products. The private development repository remains private. Some owner-authored Python files are readable inside the official preview DMG: viewing them does **not** grant a source-reuse license. Third-party licenses and mandatory statutory rights remain intact.

Publishing on GitHub **does not make the product open-source**. GitHub users can view/fork public materials under GitHub's Terms. The owner authorizes the **privacy-sanitized, signed RC15.1 preview** and the historical sanitized RC14 V8 preview for public distribution; its readable runtime source does **not** grant derivative code rights. Private repository content, credentials, signing keys and personal logs are not part of the publication.

[Binding terms and permissions](LICENSE.md) · [Publishing/acceptance levels](docs/RIGHTS.md) · [Security](SECURITY.md) · [Third-party notices](THIRD_PARTY_NOTICES.md)

## Project and acknowledgements

**Initiative, product direction and acceptance decisions:** [@StefanAlMare](https://github.com/StefanAlMare). **Technical research, drafting and development assistance:** ChatGPT (OpenAI), used as an AI assistant under the project owner's direction. This credit does not imply an OpenAI partnership, copyright transfer or endorsement. See [credits](docs/CREDITS.md).

**Naming notice:** “ChatGPT” is an OpenAI trademark. The current project/app names must be reviewed against [OpenAI's branding guidelines](https://openai.com/brand/) before public software distribution; no trademark permission or endorsement is claimed.

[Report a sanitized issue](https://github.com/StefanAlMare/ChatGPT-TrueNAS/issues) · [See full technical history](HISTORY.md)
