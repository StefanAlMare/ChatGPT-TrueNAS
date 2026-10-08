# Rights, security levels and GitHub release acceptance
## Drepturi, clasificarea securității și condiții de publicare

**Project policy, not an open-source license.** This page explains the official [Proprietary Non-Commercial Preview License](../LICENSE.md) and the distinction between **download visibility** and **legal permission to reuse code**.

## 1. What is allowed / Ce este permis

| Use | Rule |
| --- | --- |
| View/fork public project documentation | Allowed as part of GitHub's [Terms of Service](https://docs.github.com/en/site-policy/github-terms/github-terms-of-service) |
| Download and run the official preview for **personal, educational, research or other non-commercial purposes** | **Free** under the published license |
| Use in an organization for production/business/revenue-generating activity | **Prior written permission required** |
| Resell, bundle, repackage, redistribute, OEM/white-label, provide as a paid service | **Prior written permission required** |
| Incorporate any original ChatGPT Drop Python/source code into another product or derive a competing program | **Prior written permission required**, except non-waivable statutory rights |
| Exercise independent rights under third-party open-source licenses | Permitted under **the upstream licenses**, not restricted by our proprietary grant |

**Română:** downloadul nu este licență comercială. Gratuitatea privește evaluarea și utilizarea necomercială. Pentru activități comerciale, integrarea surselor, derivare, revânzare și redistribuire este necesar acordul titularului **în scris**.

## 2. Bundled source is visible, but not open-source

The owner permits **only a sanitized, newly signed derivative of RC14 V8** as the first proprietary non-commercial preview. The **original DMG includes private NAS/SMB/Tailscale defaults and must not be published**. Unauthorized code reuse and commercial use remain prohibited. Its installer includes **readable owner-authored Python runtime code**. Publishing the DMG makes those bytes **publicly accessible**; calling that code “confidential after release” or promising technical prevention of copying would be false.

Recipients may inspect the included files and execute the runtime as required for licensed non-commercial use. They receive **no general grant to republish, modify, sublicense, reuse in other products or resell** the owner's proprietary code. The private source/development repository itself is **not** copied into this public repository. Mandatory law and third-party licenses take precedence where applicable.

GitHub's terms allow public content to be viewed and forked **through the GitHub service**; those rights do not automatically constitute an independent open-source license for integration into unrelated software.

## 3. Data classification / Niveluri de securitate

| Level | Public GitHub handling |
| --- | --- |
| PUBLIC DOCS | Sanitized README, history, diagrams, instructions, license, checksums are allowed |
| AUTHORIZED PRE-RELEASE BINARY | RC14 V8 exact verified DMG may be attached to an explicit prerelease with license, known limits and checksums; **readable proprietary runtime source is intentionally disclosed as part of the artifact** |
| PRIVATE DEVELOPMENT | Owner's authoritative repository, build recipes, private checkpoints, non-distributed modifications remain private |
| USER BATCH DATA | ZIPs, logs, personal snapshots stay in managed storage, not GitHub; retain only seven days in the reference live tree unless archived elsewhere |
| SECRETS | SSH/SMB passwords, reusable VPN/Tailscale enrollment tokens, Apple signing private keys and API secrets must **never** be committed or bundled into any public asset |
| THIRD-PARTY COMPONENTS | Retain upstream rights and license notices; the owner's restrictions must not purport to override them |

## 4. Two independent validation meanings

**Batch transfer acceptance:** a frozen batch is uploaded atomically, verified at destination by byte count/SHA-256 and marked READY only when complete. This is not anti-malware certification and does not prove the current Chat can read the file.

**RC14 prerelease packaging acceptance:** the exact DMG identified by SHA-256 passes the recorded DMG/signature checks. The **release is explicitly a test preview**: independent final RC14 graphical Update/E2E, Apple notarization and deployment to other NAS devices **are not confirmed**. No generic NAS setup wizard is available; a reference-configured package should not be advertised as universally plug-and-play.

**Owner clarification, 8 October 2026:** source-bearing Python can be distributed under the non-commercial proprietary license only after removing **every personal NAS, SMB and Tailscale default** from the release and re-signing the rebuilt package. The original SHA-approved internal RC14 DMG is **not** approved for public distribution. **No passwords, private infrastructure identifiers, personal data or misleading notarization/E2E claims may be published.**

## 5. Architecture and operational protections

The Mac app uses authenticated SMB, direct/private networking or a per-installation embedded Tailscale node, and macOS Keychain for credentials. The central TrueNAS Reader is root-confined with read-only mount and tools; it must not offer deletion or shell actions. Cloud Sync makes an additional Drive copy. On the reference TrueNAS the 168-hour retention cleaner removed 31 expired directories and the Drive synchronization completed SUCCESS on 8 October 2026; separate backups and future expiry monitoring remain important.

## 6. Trademarks and third-party notices

OpenAI's [brand rules](https://openai.com/brand/) restrict OpenAI/GPT brands in third-party product names. The names “ChatGPT-TrueNAS” and “ChatGPT Drop” must not imply OpenAI affiliation or approval; a naming/legal review may require changes. TrueNAS/iXsystems, Tailscale, Apple, Google and GitHub own their respective marks. The Tailscale/tsnet binary has independent BSD-3-Clause requirements. Refer to [third-party notices](../THIRD_PARTY_NOTICES.md).

**Private written permission** for commercial/source use is requested from [@StefanAlMare](https://github.com/StefanAlMare). A GitHub Issue is not a secure licensing channel.

*This policy is not legal advice; jurisdiction-specific review is recommended.*