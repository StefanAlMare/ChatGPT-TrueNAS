# Security, privacy and support / Securitate, confidențialitate și suport

## English

This repository contains public documentation and licensing material. Application source, private development records, user configurations, operational journals, credentials, private signing keys and certificates are excluded. Do not post these in issues or attachments.

The client uses macOS Keychain for credentials and per-installation remote enrollment. No universal Tailscale auth key belongs in an installer. The Reader is read-only, root-confined and rejects symlink escapes. The embedded proxy is loopback-only. Direct SMB security also depends on the user's network and server settings; do not infer that every LAN SMB session is encrypted merely because the private remote transport exists.

Clipboard messages reveal exact file paths, sizes, hashes and batch identifiers. Logs/configuration can reveal endpoint names and user details. Redact reports before sharing. Drive mirroring introduces a separate cloud copy with its own access and deletion behavior. Verification protects transfer integrity; it does not replace backup or establish automatic retention.

Use Issues for sanitized, non-sensitive reports: app/build, macOS version/architecture, expected versus observed behavior and a minimal harmless reproduction. For a security issue, request a private reporting route from the maintainer without publicly describing exploitable private details. No dedicated private mailbox or response-time commitment is established here.

## Română

Repository-ul conține documentație și licență publică. Sursele aplicației, înregistrările private, configurațiile, jurnalele operaționale, credențialele, cheile private și certificatele nu se publică. Nu le include în Issues sau atașamente.

Credențialele și înrolarea per instalare folosesc Keychain. Reader este exclusiv pentru citire, limitat la rădăcină și respinge evadarea prin symlink-uri. Proxy-ul integrat ascultă numai local. Securitatea SMB direct depinde și de rețea/server; existența transportului privat nu dovedește criptarea fiecărei sesiuni SMB LAN.

Clipboard-ul expune căi, dimensiuni, hash-uri și identificatori de lot. Logurile/configurația pot expune utilizatori și destinații. Oglinda Drive este o copie cloud separată, cu propriile drepturi și reguli de ștergere. Verificarea transferului nu înlocuiește backup-ul sau validarea retenției.

Rapoartele publice trebuie anonimizate și bazate pe fișiere inofensive. Pentru probleme de securitate solicită autorului o rută privată, fără a publica detalii exploatabile. Nu este declarată aici o adresă privată dedicată sau un termen garantat de răspuns.
