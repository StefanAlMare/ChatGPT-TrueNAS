# RC14 V8 — first public non-commercial preview / Prima versiune publică

[README](../README.md) · [Română](../README.ro.md) · [License](../LICENSE.md) · [GitHub Releases](https://github.com/StefanAlMare/ChatGPT-TrueNAS/releases)

**Owner decision on 8 October 2026:** the first public macOS release must be a **sanitized and re-signed RC14 V8 derivative**, offered as a proprietary non-commercial prerelease. The original DMG contains private infrastructure defaults and **must not be published**, irrespective of matching SHA-256. Readable Python runtime may be included under restricted usage terms. Being able to read runtime source within the DMG does **not** license its redistribution, alteration, resale or incorporation into other products.

## Exact artifact / Identitatea artifactului

| Field | Recorded value |
| --- | --- |
| Product | ChatGPT Drop (macOS app), ChatGPT-TrueNAS (public repository) |
| Tag for initial public prerelease | `v0.9.0-rc14` |
| Candidate / build recipe | `0.9.0-rc14` / V8; app build 14 |
| Platform | macOS Intel `x86_64` |
| Filename | `ChatGPT-Drop-Installer-macOS-x86_64-0.9.0-rc14.dmg` |
| File size | `23092580` bytes |
| SHA-256 | `125802a96df9b169960ed09f65cdb893b22f85f1875d285ea67b942a9b3c6f34` |
| Native build and outer-DMG audit | PASS, recorded 12 September 2026 |
| Recovered binary, size/SHA and read-only DMG/signature audit | PASS, recorded 8 October 2026 |
| Full graphical Update and runtime E2E on **this exact RC14 V8** | **NOT CONFIRMED** |
| Apple notarization and stapling | **NOT CONFIRMED** |
| Generic NAS/end-user onboarding | **NOT VERIFIED; reference-specific assumptions remain** |
| Prior accepted internal macOS baseline | RC13 (history/rollback reference, **not another public release**) |

**Distribution check:** the original artifact identity below is **private reference evidence only**. A sanitized release must carry a **different SHA-256**. An actual download exists **only when [GitHub Releases](https://github.com/StefanAlMare/ChatGPT-TrueNAS/releases) lists a real asset with the exact filename and matching checksum**. Documentation or a tag alone must never be called a completed software release.

## Why this is proprietary despite source being readable / De ce rămâne proprietar

The DMG includes a readable owner-authored Python runtime file, such as `ChatGPT Drop Installer.app/Contents/Resources/runtime/chatgpt_drop.py`. The owner knowingly authorizes disclosure **inside this specific installer**. It remains subject to the [non-commercial proprietary license](../LICENSE.md): non-commercial personal/educational/research use may be free; **commercial use, repackaging, redistribution, derivative works, OEM, paid hosting and code integration require prior written permission**. Independent third-party open-source permissions are preserved.

**Română:** DMG-ul original include Python proprietar lizibil. Titularul autorizează distribuirea **acestui fișier exact**, nu reutilizarea codului în alte produse. Utilizarea comercială cere acord scris; licențele terțe se respectă.

## How to test / Cum se testează

- Obtain the installer from an actual verified release asset. Compare SHA-256 and file size before opening it.
- Open `ChatGPT Drop Installer.app` and choose Install/Update as appropriate on a test Intel Mac. Preserve and back up existing setup data. This exact RC14 Update is **not independently accepted** in current evidence.
- The current package derives from the owner's reference TrueNAS environment; **it does not provide a fully validated generic server/share/account setup wizard**. Other users may require an adapted deployment. Do not claim that SMB host selection is configurable merely because the password can be stored in Keychain.
- Use a harmless Finder Quick Action batch; require destination bytes/hash/READY; then actual content read through Reader/MCP or Drive. Tailscale private enrollment is per installation and no reusable auth key is included.
- Reader is separate from upload; Google Drive is an optional mirror; seven-day retention is a separate server job. The 30/900 clipboard settings request retry behavior but are **not** a guaranteed autonomous background timer.

If Gatekeeper refuses the downloaded app, **do not circumvent macOS security automatically**. There is no confirmed Apple notarization acceptance; consult the maintainer.

## Limitations and next validation

Public pre-release distribution is **not** the same as declaring RC14 universally functional. The current client is Intel only; Apple Silicon, Windows/Ubuntu, local folders/external drives and arbitrary SMB NAS compatibility are unvalidated/not implemented as appropriate. A source-free standalone redistribution is a separate future packaging track, not a prerequisite to the owner's specifically authorized RC14 preview.

[Development history](../HISTORY.md) · [Detailed status](STATUS.md) · [TrueNAS/generic NAS setup](SETUP.md) · [Third-party licenses](../THIRD_PARTY_NOTICES.md).

**Trademark notice:** The name “ChatGPT” belongs to OpenAI; no endorsement or permission is claimed. Public product branding may require revision under [OpenAI's guidelines](https://openai.com/brand/).