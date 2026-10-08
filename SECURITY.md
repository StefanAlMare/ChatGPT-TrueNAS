# Security policy / Politica de securitate

This is a **proprietary product**, not open-source. The owner permits the **exact RC14 V8 reference DMG** to appear as an official non-commercial preview, even though it includes readable proprietary Python runtime files. This is **not a license to reuse them**. All other private source, personal batches, signing material, credentials, internal logs and secrets remain excluded from this public repository and its releases.

## Trust boundaries / Limite de încredere

| Boundary | Required safeguards |
| --- | --- |
| Finder/Mac upload | Copy selected originals; freeze stable batch; atomic temporary write; verify destination BYTES + SHA256; persist queue/journal for retry; no READY before whole batch verifies |
| Network | Authenticated SMB over local/private network; embedded Tailscale helper uses per-installation enrollment and loopback listener; no public SMB/445 or universal auth key |
| macOS credentials | Keychain; never put SMB passwords/Tailscale keys in source, clipboard messages or issue logs |
| TrueNAS Reader | Single central read-only MCP service; `:ro` mount of managed root; path confinement, reject symlinks/escapes; **no remote shell, upload, rename or delete tools** |
| Chat/Work content | Exact file identity (PATH/BYTES/SHA256) **and actual content reading**; tool visibility is session-specific; zero Drive search results are not proof of absence |
| Google Drive | Mirror is a second cloud copy. Restrict folder permissions; monitor Cloud Sync; delete expired files through configured `PUSH + SYNC` |
| Retention | Reference cleaner targets only recognized managed batch folders 168 hours after batch UTC creation; initial 31 expired batches/Drive sync SUCCESS on 8 Oct; retention is not backup or assured secure erasure |
| Public GitHub release | Owner-authorized **RC14 V8 DMG exception** permits readable proprietary runtime source under a non-commercial license. Still require no embedded secrets, honest integrity/signature/notarization status, upstream notices, deployment limitations and actual asset/hash verification. |

## Two meanings of “accepted” / Două sensuri ale acceptării

**File batch accepted:** destination size/hash validated for the whole batch; local source and recovery state remain protected. No malware or content-safety screening is implied by a hash match. File contents are not automatically accessible to ChatGPT until the authorized Reader or Drive connector reads them.

**Public distribution acceptance is separate.** The owner explicitly authorizes the **unchanged RC14 V8 DMG** as a non-commercial prerelease, acknowledging that proprietary Python runtime source may be readable by recipients. Publication grants **no rights to reuse that code in other products**. The hash/signature audit passed; full RC14 graphical Update/E2E, notarization and generic NAS setup remain unconfirmed and must be described as such. Do not include any secrets, personal data or unlicensed dependencies. Verify an actual asset on GitHub Releases before claiming a public download exists.

## Reporting a problem / Raportare

- Open a [GitHub Issue](https://github.com/StefanAlMare/ChatGPT-TrueNAS/issues) **only for sanitized** public bug reports, documentation corrections or feature requests.
- Include app version/build, operating system, expected vs actual behavior and a harmless reproduction. Remove user names, private hostnames, addresses, paths, tokens, private ZIP contents and other personal information.
- For sensitive vulnerabilities, request a **private channel** with [@StefanAlMare](https://github.com/StefanAlMare); do not publicly disclose working secrets or exploitable internal details. No special mailbox or response-time commitment is asserted.

## Intellectual property and trademarks / Drepturi și mărci

Public visibility does not make private code open-source. The policy for viewing/forking GitHub public content and for distributing official binaries is in [LICENSE.md](LICENSE.md) and [docs/RIGHTS.md](docs/RIGHTS.md). “ChatGPT” is an OpenAI mark; review [OpenAI branding rules](https://openai.com/brand/) before public product distribution. No endorsement/partnership is implied.

## Română — pe scurt

**Excepție autorizată:** RC14 V8 poate fi publicat ca pre-release proprietar **necomercial**, deși DMG-ul conține fișiere Python lizibile. Aceasta **nu autorizează reutilizarea codului** în alte produse. **Nu publica:** chei, parole, token-uri, jurnale private, fișiere ale utilizatorilor, repository-ul intern ori alte surse neautorizate. Reader rămâne `:ro`, iar READY înseamnă transfer verificat, nu analiză efectuată de ChatGPT. Retenția la șapte zile nu înlocuiește backupul.
