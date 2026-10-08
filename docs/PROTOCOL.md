# File discovery and content analysis / Descoperire și analiză

**For a new Chat, Project or Work:** start with the [handover](HANDOVER.md), then the [three route diagrams](ROUTES.md). Reader/MCP tool access and timing abilities must be checked in the actual session. **Do not claim an automatic timer was started solely because this protocol mentions 30 seconds/900 seconds.**

## English

The clipboard message is a self-contained **FIND + ANALYZE** contract for the receiving assistant. Its rules are packaged in RC14 V8, but their execution on a real RC14 batch remains unvalidated. Tool availability, access permissions, format support and the assistant's ability to retry determine what can actually run.

1. **Locate immediately.** Prefer Reader/MCP, starting with the batch listing and exact returned paths. If Reader is unavailable, immediately traverse the configured Drive mirror through category → date → batch → expected file.
2. **Match identity.** Use exact filename/path and byte count, plus SHA-256 when exposed. Metadata establishes identity, not content.
3. **Retry direct traversal.** If the batch or file has not appeared, repeat the relevant folder listing every **30 seconds**, until **900 seconds from the first lookup attempt**. If a batch folder exists but a child is missing, re-list that folder.
4. **Search only as fallback.** Empty global search results are not proof that a freshly mirrored file is absent. Search must not replace direct retries.
5. **Report timeout precisely.** Identify whether discovery failed at the date folder, batch folder or expected child. Do not invent a successful read.
6. **Analyze at source.** Use list/find/member-info/chunk/range reads where supported. Inspect ZIP members server-side rather than downloading the complete archive by default.
7. **Full transfer is a last resort.** Use it only if the available source tools cannot inspect the needed format, and explain why.
8. **Read actual content.** Names, sizes, MIME types and hashes cannot support claims about a document's contents.

Required clipboard controls are `LOCATE_RETRY_SECONDS=30`, `LOCATE_TIMEOUT_SECONDS=900`, and exact `PATH | BYTES | SHA256` entries for each expected file. The older 6/8/10-minute grace schedule is superseded; there is no mandatory initial wait.

The Reader supports `list_batch`, directory listing/search, text and binary chunks, text tails, selected image/file responses and ZIP member listing/search/info/chunk reading. A bounded single-response file fetch is not a promise of unlimited object transfer. The historical Drive connector test hit a **256 MiB raw-object download limit**; that is an observed limitation of the tested connector, not a universal current limit for all Drive integrations. A large ZIP therefore needs an appropriate member-level Reader or another supported source inspection route.

Where the returned path begins `ChatGPT-Live/`, remove only that prefix when resolving under the configured `ChatGPT Project Bridge` Drive mirror. Preserve the category/date/batch structure.

## Română

Mesajul din clipboard transmite asistentului un contract **FIND + ANALYZE**. Regulile sunt incluse în pachetul RC14 V8, dar executarea lor pe un lot RC14 real rămâne nevalidată. Disponibilitatea uneltelor, permisiunile, formatele acceptate și posibilitatea asistentului de a relua căutarea determină ce se poate executa efectiv.

Se încearcă imediat Reader/MCP și listarea lotului. Dacă Reader nu este disponibil, se traversează imediat oglinda Drive: categorie → dată → lot → fișier. Identitatea se verifică prin nume/cale exacte și octeți, plus SHA când este disponibil. Pentru un lot sau fișier încă nevizibil se repetă listarea directă la **30 de secunde**, până la **900 de secunde de la prima încercare**. Căutarea globală este doar rezervă; lipsa rezultatelor nu dovedește absența unui fișier proaspăt sincronizat.

La expirarea timpului se indică exact folderul de dată, folderul de lot sau fișierul la care descoperirea a eșuat. Conținutul se inspectează la sursă prin listare, căutare și citire pe fragmente. ZIP-urile se analizează la nivel de membri când Reader permite acest lucru. Transferul integral este ultima opțiune și trebuie explicat. Metadatele nu înlocuiesc citirea conținutului.

Clipboard-ul include `LOCATE_RETRY_SECONDS=30`, `LOCATE_TIMEOUT_SECONDS=900` și `PATH | BYTES | SHA256` pentru fiecare fișier. Vechea schemă de așteptare 6/8/10 minute a fost înlocuită. Testul istoric al conectorului Drive a întâlnit o limită de **256 MiB pentru descărcarea unui obiect integral**; aceasta descrie conectorul testat atunci, nu toate integrările Drive actuale.

Pentru oglinda `ChatGPT Project Bridge`, din calea care începe cu `ChatGPT-Live/` se elimină numai acel prefix. Structura categorie/dată/lot se păstrează.
