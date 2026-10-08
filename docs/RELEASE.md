# RC14 V8 artifact and publication record / Artifact și publicare

Reviewed / Revizuit: **8 October 2026 / 8 octombrie 2026**.

## Exact candidate / Candidatul exact

| Field | Value |
| --- | --- |
| Product | ChatGPT Drop |
| Release label | ChatGPT Drop 0.9.0-rc14 V8 |
| App build | 14 |
| Platform | macOS Intel x86_64 |
| Installer filename | `ChatGPT-Drop-Installer-macOS-x86_64-0.9.0-rc14.dmg` |
| Bytes | `23092580` |
| SHA-256 | `125802a96df9b169960ed09f65cdb893b22f85f1875d285ea67b942a9b3c6f34` |
| Native build and outer audit recorded | 12 September 2026 |
| Artifact recovered and independently checked | 8 October 2026 |
| Graphical Update and runtime E2E | Not yet validated / Încă nevalidate |
| Accepted baseline | RC13; RC14 not promoted / RC14 nepromovat |
| Public release | **Not published: source-disclosure constraint** / **Nepublicat: restricția divulgării surselor** |

## Fresh verification / Reverificare

The artifact was located through Reader/MCP in the owner-supplied batch. The Reader reported matching bytes/SHA. Because DMG inspection is not supported server-side, the original file was recovered in bounded binary ranges for local inspection and prospective release upload. Local byte count and SHA-256 independently matched. Disk-image integrity verification and signature checks for the DMG, graphical installer, embedded application and tsnet helper passed. The image was mounted read-only; no installer or app was executed. The runtime contains the 30-second/900-second protocol controls.

Artifactul a fost localizat prin Reader/MCP în lotul furnizat de autor. Identitatea raportată a coincis. Deoarece Reader nu inspectează DMG-uri pe server, fișierul a fost recuperat pe fragmente pentru audit local și eventuala publicare. Octeții/SHA au coincis independent. Integritatea imaginii și semnăturile DMG/installer/aplicație/helper au trecut verificarea. Montarea a fost exclusiv pentru citire, fără executarea aplicației sau installerului. Markerii 30/900 sunt prezenți.

## Why no public asset / De ce nu există asset public

The exact DMG contains **`ChatGPT Drop Installer.app/Contents/Resources/runtime/chatgpt_drop.py`**, a 41,294-byte proprietary Python source file, alongside runtime/support material. Publishing that unchanged DMG would expose this source. The owner's publication requirement keeps proprietary source private. Removing or repackaging the source would change the required SHA-256 and signatures, so a modified installer cannot be presented as this exact candidate.

DMG-ul exact conține fișierul Python proprietar de **41.294 de octeți** indicat mai sus. Publicarea DMG-ului neschimbat ar expune sursa. Cerința autorului păstrează sursele private. Eliminarea sau reîmpachetarea ar schimba SHA-256 și semnăturile; un installer modificat nu poate fi prezentat drept candidatul exact cerut.

No release, empty placeholder, older version or substitute asset is published. A future release must resolve the source-distribution boundary and retain an accurate verification and validation record. If the owner explicitly authorizes the bundled runtime source exception, that decision must be reflected in this record and the license before distribution. Otherwise, a new source-free artifact needs its own identity and authorization.

Nu se publică release gol, versiune veche sau asset substituit. O distribuție viitoare trebuie să rezolve limita divulgării surselor și să păstreze rezultatele reale ale verificărilor. O excepție explicită autorizată de autor trebuie reflectată aici și în licență. În lipsa ei, un artifact fără surse necesită identitate și autorizare proprii.

The publication status is also recorded in [release-manifest.json](../release-manifest.json). It is an artifact identity/status record, not a claim that an asset is downloadable.

Stadiul apare și în [release-manifest.json](../release-manifest.json). Manifestul identifică artifactul și starea sa; nu susține că poate fi descărcat.
