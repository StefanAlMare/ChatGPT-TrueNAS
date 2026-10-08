# Proprietary rights, security levels and GitHub acceptance
## Drepturi proprietare, niveluri de securitate și condiții de publicare

**Status:** owner policy for a proprietary project; technical disclosure controls, not a guarantee against unlawful copying or a substitute for counsel's legal review.

## 1. Public use is not open source / Utilizare publică ≠ open-source

| Activity / Activitate | Intended permission / Drepturi acordate |
| --- | --- |
| **View project documentation** | Yes, on GitHub; public GitHub functionality includes viewing and forking its public contents |
| **Download and run an official compiled release** | **Free**, including personal and ordinary internal use at an organization, when an official release actually exists |
| **Use the private source, copy it into another product or modify it** | **Only with prior written permission** from the rights holder |
| **Redistribute/repackage binaries, white-label, OEM, bundle, resell or monetize this product** | **Prior written permission / separate commercial license required** |
| **Offer the software or its functionality as a paid hosted/service integration** | **Prior written permission / separate commercial agreement required** |
| **Modify or use third-party open-source components independently** | The relevant **third-party license** controls, not the owner's proprietary restrictions |
| **Statutory rights that cannot legally be waived** | Always preserved |

**RO:** gratuit pentru utilizarea binarului oficial (inclusiv folosire internă într-o organizație); **nu** este acord pentru revânzare, distribuție proprie, comercializare, licențiere OEM, cod-sursă ori derivări. Acestea necesită contract/permisiune scrisă. Termenii pentru utilizarea internă în firme și pentru **exploatarea comercială a produsului** sunt diferiți.

Current legal text: [LICENSE.md](../LICENSE.md). Intellectual-property protection is contractual/copyright-based to the extent applicable; neither GitHub nor an unregistered mark automatically provides patents, secrecy after disclosure, or exclusive rights in a product idea.

## 2. What GitHub permits even on a proprietary public repository

GitHub [Terms of Service, Content license to other users](https://docs.github.com/en/site-policy/github-terms/github-terms-of-service) give users the right to **view and fork public contents using GitHub's features**. [GitHub licensing guidance](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/licensing-a-repository) says that a repository without an open-source license does **not** thereby grant broad rights to distribute, adapt or incorporate source in another product. A proprietary `LICENSE.md` can grant **limited binary-use** rights without turning the source open-source.

**Consequence / Consecință:** never publish secret algorithms, `.py` runtime, source-bearing DMGs, private build recipes with privileged details, signing keys, API/SMB/Tailscale secrets or personal logs expecting the public repository license to keep them unreadable. Public GitHub history/forks and downloaded assets cannot be reliably recalled after exposure.

**Never describe a GitHub-visible file as confidential.** A public issue, wiki, commit, diff, release asset and branch may be accessible and copied.

## 3. Security classification / Ce fișiere sunt acceptate

| Level | Examples | Placement / GitHub admission rule |
| --- | --- | --- |
| **PUBLIC DOCS** | Sanitized README, history, diagrams, guide, license, notices, checksums | **Allowed** in public repo after review: no secrets, exact private hostnames/identifiers or user data |
| **PUBLIC BINARY CANDIDATE** | Source-free distributable installer | **Conditional**: code/secret audit, third-party notices, build provenance, BYTES/SHA256, Developer ID verification, notarization/Gatekeeper evidence, native install/update/uninstall and actual end-to-end tests |
| **PRIVATE SOURCE** | App core (`chatgpt_drop.py`), Reader server, build/patch scripts, private checkpoints | **Private repository only**; access only to authorized collaborators; no public source license |
| **USER DATA** | ZIPs, package files, diagnostics, batch logs, selected Finder files | **Managed private storage only** (`ChatGPT-Live` with 168h TTL); not GitHub releases or issues; permanent copies stored outside expiring tree |
| **SECRET / CREDENTIAL** | Passwords, auth tokens, SSH/SMB keys, Tailscale enrollment, Apple signing private key | **Never in GitHub or ChatGPT prompts**; use Keychain or TrueNAS secret storage; rotate promptly if exposed |

**Accepting an upload into ChatGPT Drop** is **not equivalent** to accepting it as a **GitHub Release**. The application verifies that bytes reached the NAS; it does not promise antivirus scanning or endorse unknown file contents.

## 4. Two independent acceptance gates / Două validări diferite

**Batch/data acceptance:** filename/category/UTC batch ID → stable inputs → frozen journal → atomic temporary upload → destination BYTES + SHA256 → **READY** for the whole batch. If transfer fails, staged copies and journal stay for retry. **READY does not prove that ChatGPT read the file.** Reader/Drive content reading is a separate test.

**Public release acceptance:** owner-authorized source-free build → no secrets/private provisioning → mandatory upstream copyright notices → tested product permissions and credentials → binary integrity/signatures (and notarization as required for target distribution) → native installation/E2E → correct version/checksum manifest and honest pre-release label. Do **not** publish an artifact just because an earlier candidate had `codesign PASS`. A failed gate blocks public upload rather than inviting a misleading release.

**Known block (8 Oct 2026):** `0.9.0-rc14 V8` DMG is hash-verified, but it contains the proprietary `runtime/chatgpt_drop.py` source in readable form. It **must not be published unchanged** under the no-source-disclosure condition. An altered installer needs a **new** SHA256/signature and independent tests; do not reuse the old manifest.

## 5. Operational security / Securitate în exploatare

- **Private upload:** authenticated SMB, direct local/private network or individual embedded private Tailscale node; no public SMB/445 or shared enrollment key.
- **Read-only Reader:** mount only managed data `:ro`; limit to real root; reject symlinks/path escapes; never provide delete/upload/shell tools through the MCP Reader.
- **Separated credentials:** Keychain on Mac, per-service restricted NAS secrets; secure central MCP tunnel configured once.
- **Mirror visibility:** Google Drive is an additional cloud copy; verify exact folder access and retention propagation.
- **Retention:** reference TrueNAS deletes eligible managed batches after 168h, not unrelated data. Initial 31-batch removal and Drive sync SUCCESS verified 8 Oct. This is not backup or guaranteed forensic erasure.
- **Reporting:** post **sanitized** bugs and logs only; do not post SMB share IPs, private network details, tokens or client files.

## 6. Names, marks and third-party rights / Mărci și dependențe

`ChatGPT`, `GPT`, `OpenAI` and related logos belong to OpenAI. The current names **ChatGPT-TrueNAS** and **ChatGPT Drop** require a **brand/trademark review** before public binary distribution: [OpenAI brand rules](https://openai.com/brand/) include restrictions on use of the GPT brand in app/product names. No use of OpenAI's logo, approval or partnership is implied. Product naming may need adjustment; a repository name does not provide trademark clearance.

`TrueNAS`, `Tailscale`, `Apple`, `Google Drive` and `GitHub` belong to their respective holders. The embedded Tailscale/tsnet code carries its independent BSD-3-Clause obligations; hosted-service/commercial terms are a separate review. See [third-party notices](../THIRD_PARTY_NOTICES.md).

## 7. Rights requests / Solicitări de autorizare

For source access, commercial redistribution, OEM/white-label projects, licensing, resale or paid hosting, request **a private written agreement with the repository owner** via [@StefanAlMare](https://github.com/StefanAlMare). A public GitHub issue is not a secure licensing channel and does not grant rights by silence. No fee structure or sublicensing permission is implied.
