# Security policy / Politica de securitate

This is a **proprietary, source-private** product with publicly readable documentation. Do not upload private source, production binaries containing source, internal checkpoints, key material, full user batches, private diagnostics or secret-bearing logs to this public repository, its Issues, Pull Requests or Releases.

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
| Public GitHub release | Source-free binary only; secret/IP audit, third-party notices, verified build identity/checksum/signing, native deployment tests and truthful notarization status; block unsafe or unverified assets |

## Two meanings of “accepted” / Două sensuri ale acceptării

**File batch accepted:** destination size/hash validated for the whole batch; local source and recovery state remain protected. No malware or content-safety screening is implied by a hash match. File contents are not automatically accessible to ChatGPT until the authorized Reader or Drive connector reads them.

**Public distribution accepted:** a **separate** audit must establish that a downloadable binary contains no prohibited proprietary source, configuration secrets or unlicensed third-party material, and has appropriate integrity, platform tests and release notes. The existing RC14 V8 DMG does not meet the source-disclosure boundary (it embeds Python source) even though its SHA/signature audit passed. **No official public installer has been released.**

## Reporting a problem / Raportare

- Open a [GitHub Issue](https://github.com/StefanAlMare/ChatGPT-TrueNAS/issues) **only for sanitized** public bug reports, documentation corrections or feature requests.
- Include app version/build, operating system, expected vs actual behavior and a harmless reproduction. Remove user names, private hostnames, addresses, paths, tokens, private ZIP contents and other personal information.
- For sensitive vulnerabilities, request a **private channel** with [@StefanAlMare](https://github.com/StefanAlMare); do not publicly disclose working secrets or exploitable internal details. No special mailbox or response-time commitment is asserted.

## Intellectual property and trademarks / Drepturi și mărci

Public visibility does not make private code open-source. The policy for viewing/forking GitHub public content and for distributing official binaries is in [LICENSE.md](LICENSE.md) and [docs/RIGHTS.md](docs/RIGHTS.md). “ChatGPT” is an OpenAI mark; review [OpenAI branding rules](https://openai.com/brand/) before public product distribution. No endorsement/partnership is implied.

## Română — pe scurt

**Nu publica în GitHub public:** surse private, DMG-ul RC14 V8 cu sursă Python inclusă, parole, token-uri, chei, loguri și fișiere de utilizator. **Citirea și scrierea sunt separate:** Reader este exclusiv pentru citire, cu montare `:ro` și tunel MCP central; ChatGPT trebuie să verifice conținutul real. **READY** confirmă transferul verificat, nu autorizarea fișierului ca release public. Retenția la 7 zile funcționează pe TrueNAS de referință, dar nu înlocuiește backupul și nu garantează ștergerea definitivă a tuturor copiilor.
