# ChatGPT Drop · ChatGPT-TrueNAS

**Verified file batches from Finder to your storage, with a precise handoff to ChatGPT.**

[Română](README.ro.md) · [Installation](docs/INSTALLATION.md) · [Architecture](docs/ARCHITECTURE.md) · [History](HISTORY.md) · [Status](docs/STATUS.md) · [Roadmap](docs/ROADMAP.md)

**ChatGPT Drop** is the Apple/macOS application. **ChatGPT-TrueNAS** is its public documentation and release repository, maintained by [StefanAlMare](https://github.com/StefanAlMare).

The application groups selected files into a stable batch, transfers them to TrueNAS over SMB, verifies destination byte counts and SHA-256 hashes, and prepares a clipboard message that identifies the exact files for ChatGPT. A read-only Reader/MCP service or a configured Google Drive mirror provides access to the content.

## Availability and honest release status

| Item | Status |
| --- | --- |
| Latest candidate | **ChatGPT Drop 0.9.0-rc14 V8**, app build 14 |
| Candidate native build, signing and outer-DMG audit | Recorded PASS on Intel macOS, 12 September 2026 |
| RC14 V8 graphical Update and end-to-end use | **Not yet validated** |
| Accepted internal macOS baseline | RC13, including a user-validated off-LAN transfer and Drive content read |
| Public installer | **Withheld: the exact hash-verified DMG contains proprietary Python source** |
| GitHub release | **No release published** under the current no-source-publication requirement |
| Local folder / external drive | Planned; adapters are not implemented |
| Other SMB NAS devices | Architectural target; no independent compatibility validation |
| Windows / Ubuntu / Apple Silicon native build | Not validated for public release |

This status was reviewed on **8 October 2026** against the development records. Historical PASS results describe their recorded environment; they are not fresh RC14 end-to-end tests. See the [full validation matrix](docs/STATUS.md) and [artifact record](docs/RELEASE.md).

## Free application, private proprietary source

**Anyone may use an officially released compiled application free of charge, including for personal or business use.** The application source remains proprietary and private. Using, modifying or redistributing the proprietary source requires **prior written permission from StefanAlMare**. This repository does not grant an open-source license.

The [license](LICENSE.md) distinguishes free binary use from source rights. Third-party components retain their own licenses. External accounts, storage, connectivity and service charges are separate from the free application license.

## How it works

1. Select ordinary files in Finder and choose **Quick Actions → Send to ChatGPT Drop**.
2. The action copies files into a hidden queue. The original Finder files stay in place.
3. After inputs settle, the client freezes a batch with a persistent device identity and a collision-resistant batch ID.
4. It prefers direct SMB on the LAN or a reachable private network. Off-LAN, the RC13 architecture uses an embedded Tailscale/tsnet helper and a loopback-only proxy to the same SMB destination.
5. Temporary writes, destination byte/SHA verification and a persisted journal protect retry/resume. READY and the clipboard handoff follow whole-batch verification.
6. Paste the message into a ChatGPT environment with the appropriate Reader or Drive connector. Content access depends on that environment and its permissions.

The active layout is `ChatGPT-Live/<category>/<date>/<batch-id>/<filename>`. Categories retain their established names: `Poze`, `Documente`, `Loguri`, `Arhive`, `Video`, `Audio`, `Diverse`.

RC14 V8's clipboard protocol requests immediate Reader lookup, immediate direct Drive traversal when Reader is unavailable, then retries every **30 seconds** for up to **900 seconds** from the first lookup attempt. It asks the assistant to inspect content at source and transfer entire objects only when needed. These are instructions carried in the handoff, not proof that every ChatGPT environment executes them automatically. [Protocol details](docs/PROTOCOL.md).

## Installation and first use

The exact candidate has been recovered and hash-verified, but it is not publicly downloadable because it includes proprietary runtime source. If distribution is authorized, the expected entry point is **ChatGPT Drop Installer.app**, with **Install**, **Update** and **Uninstall**. Installation into `/Applications` requests normal macOS administrator authorization. RC14 Update remains a pending validation gate.

The current candidate is an **Intel x86_64 macOS build** derived from an internal deployment. It is not yet a universal self-service installer for arbitrary NAS accounts: endpoint provisioning and deployment-specific settings still require maintainer adaptation and testing. The SMB credential menu is not a complete storage setup wizard.

The [installation guide](docs/INSTALLATION.md) covers TrueNAS preparation, the macOS workflow, private remote access, generic SMB NAS requirements and the local-storage roadmap. Reader deployment also needs a separately supplied authorized package; this public repository contains no server implementation or container image.

## Designed to fail safely

- Local staged files and the frozen journal survive transfer failures.
- READY means the batch verified; it does not mean ChatGPT already read the files.
- SMB credentials and Tailscale enrollment material belong in macOS Keychain.
- TrueNAS remains the storage authority; Google Drive is a read mirror.
- Reader is read-only, confined to its configured root and rejects symlink escapes.
- Public HTTPS/Funnel/zrok/SFTP experiments are historical and are not part of the current upload architecture.

[Architecture and trust boundaries](docs/ARCHITECTURE.md) · [Security and support](SECURITY.md)

## Development and participation

[HISTORY.md](HISTORY.md) follows the project from the September 2026 prototype through every numbered RC stage and RC14 V8, including failed and superseded candidates. [The roadmap](docs/ROADMAP.md) prioritizes RC14 validation, public distribution readiness, storage profiles and native platform testing. The public Git history begins with this documentation publication; it does not recreate or expose the private development Git history.

Use [Issues](https://github.com/StefanAlMare/ChatGPT-TrueNAS/issues) for sanitized bug reports, documentation corrections and feature requests. Source contributions and source access require written permission. No GitHub Actions workflows are supplied.

ChatGPT, OpenAI, Apple, TrueNAS, Google Drive and Tailscale are names of their respective owners. This project does not claim their sponsorship or endorsement.
