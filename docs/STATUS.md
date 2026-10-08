# Feature and validation status / Stadiul funcționalităților

Reviewed / Revizuit: **2026-10-08**.

**Accepted baseline: RC13. Active candidate: RC14 V8. RC14 is not promoted.**

**Versiune acceptată: RC13. Candidat activ: RC14 V8. RC14 nu este promovat.**

Recorded acceptance is environment-specific. A build/static audit PASS cannot substitute for installing that exact candidate and exercising its real workflow. The October publication audit did not install or launch the application or modify a NAS.

Acceptarea istorică privește mediul testat. Un build sau audit static PASS nu înlocuiește instalarea candidatului exact și utilizarea reală. Auditul din octombrie nu a instalat/lansat aplicația și nu a modificat NAS-ul.

| Capability / Funcție | Evidence and actual limit / Dovezi și limită reală |
| --- | --- |
| Finder selection → hidden queue → READY | Accepted macOS lineage through RC13; RC14 regression test pending / Acceptat până la RC13; regresia RC14 de testat |
| Frozen journal, byte/SHA verification, retry/resume | Established core invariants preserved by RC14 source/package gates; real RC14 interrupted-transfer test not recorded / Invariante păstrate în verificările RC14; test real RC14 de întrerupere neconsemnat |
| Direct LAN SMB | RC12 accepted and RC13 baseline preserved / Acceptat RC12, păstrat RC13 |
| Embedded tsnet off-LAN SMB | RC13 real native SMB and user hotspot E2E accepted / SMB nativ și test hotspot RC13 acceptate |
| No separate Mac Tailscale client | RC13 embedded design and native evidence; per-installation enrollment and NAS peer still required / Confirmat RC13; înrolarea și peer-ul NAS rămân necesare |
| Status colors, READY and clipboard | Accepted lineage; green represents whole-batch verification, not Reader availability / Linie acceptată; verde nu confirmă disponibilitatea Reader |
| Copy Last, Quit, login preference | Present in accepted product contract; no independent complete RC14 regression matrix / Prezente; matricea completă RC14 lipsește |
| Reader read-only confinement | Implemented, with historical MCP metadata/text and ZIP/chunk tests / Implementat și testat istoric pentru metadate/text/ZIP/fragmente |
| Reader availability in every ChatGPT chat/project | Not guaranteed; actual tool exposure varies / Negarantată; depinde de uneltele expuse |
| Large ZIP analysis | Historical ~723 MB isolated Reader ZIP test; format/tool support and connector limits still apply / Test Reader istoric izolat; limitele formatelor/conectorilor rămân |
| Google Drive mirror and small-content reads | RC12/RC13 accepted; mirror lag observed; historical 256 MiB raw download limit in tested connector / Acceptate; întârziere observată și limită istorică a conectorului testat |
| Immediate lookup / 30-second retry / 900-second timeout | Markers present in exact V8 runtime, freshly inspected; execution on a real RC14 content batch unvalidated / Markeri confirmați acum; executarea pe un lot RC14 real nevalidată |
| SMB StorageBackend abstraction | In RC14 package/source parity; only SMB backend exists / Inclusă RC14; există numai SMB |
| Generic NAS setup wizard / broad compatibility | Planned; current internal package has fixed provisioning assumptions / Planificat; pachetul actual are presupuneri fixe |
| Local folder and external-volume destination | **Not implemented** / **Neimplementate** |
| 168-hour TrueNAS retention | Source ready; native deletion and mirror propagation unvalidated / Sursă pregătită; ștergerea și propagarea nevalidate |
| Configurable retention per storage profile | Roadmap / Planificat |
| Windows / Ubuntu | Packaging preparation only; native release validation pending / Pregătire pachete; validare nativă în așteptare |
| Apple Silicon native / universal macOS | Not established for this x86_64 candidate / Nestabilit pentru candidatul x86_64 |
| Universal three-platform distribution | Not released; gated on native acceptance on each platform / Nelansată; necesită acceptarea fiecărei platforme |
| RC14 graphical Update/state preservation/app launch | **Not yet validated** / **Încă nevalidate** |
| RC14 V8 DMG bytes/SHA, integrity and signatures | Fresh checks PASS on 8 October, without install / PASS reverificat la 8 octombrie, fără instalare |
| Source-free public binary packaging | **Fails current publication boundary: proprietary Python source is bundled** / **Nu respectă cerința actuală: sursă Python proprietară inclusă** |
| Notarization acceptance | Not established by available evidence / Nedovedită de informațiile disponibile |

## RC14 acceptance still required / Validări RC14 rămase

1. Graphical Update from the exact candidate; app launch and configuration/state/Keychain preservation / Update exact, lansare și păstrarea stării/configurației/Keychain.
2. Harmless Finder batch through direct SMB and the private embedded transport / Lot de test prin SMB direct și transportul privat integrat.
3. Destination bytes/SHA and READY only after the whole batch verifies / Octeți/SHA și READY numai după verificarea întregului lot.
4. Real clipboard controls plus actual content reading through Reader or the configured Drive fallback / Markeri reali clipboard și citirea conținutului prin Reader sau Drive.
5. Regression checks for retry/resume, Copy Last, Quit and login behavior / Regresii pentru reluare, ultimul mesaj, Quit și pornire.

Public distribution readiness is a separate gate from RC14 runtime acceptance. No automatic cleanup or platform support is inferred from future design documents.

Pregătirea distribuției publice este separată de acceptarea runtime-ului RC14. Documentele de proiectare viitoare nu dovedesc ștergerea automată sau suportul altor platforme.
