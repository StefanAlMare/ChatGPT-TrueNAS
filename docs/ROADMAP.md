# Roadmap

Priorities are ordered, not release-date commitments. / Prioritățile sunt ordonate, fără promisiuni de date.

| Priority | English | Română | Completion evidence / Dovadă |
| --- | --- | --- | --- |
| 1 | Resolve public installer packaging and source-disclosure boundary | Rezolvarea împachetării publice și a limitei divulgării surselor | Source/secret audit, complete third-party notices, exact authorized artifact / Audit, notificări și artifact autorizat exact |
| 2 | Complete RC14 V8 native Update and E2E acceptance | Validarea nativă Update și E2E RC14 V8 | State preserved; real verified batch; actual content read; regression matrix / Stare păstrată, lot verificat, conținut citit, regresii |
| 3 | General deployment provisioning | Configurare pentru instalări independente | No private deployment assumptions; host/share/account/peer setup tested / Fără presupuneri private; configurare testată |
| 4 | Implement local-folder backend | Implementarea backend-ului local | Same journal, atomic write, byte/SHA and READY semantics; native E2E / Aceleași garanții, test nativ |
| 5 | Implement external-volume backend | Implementarea backend-ului extern | Stable volume identity, unplug/replug and safe resume tests / Identitate stabilă, reconectare și reluare sigură |
| 6 | Named storage profiles and wizard | Profiluri de stocare și asistent | Create/edit/test/switch profiles; one active destination; credentials in Keychain / Gestionare/testare/schimbare, destinație unică, Keychain |
| 7 | Broaden generic SMB NAS compatibility | Extinderea compatibilității NAS SMB | Device-specific atomicity, interruption, verification and Reader tests / Teste pe dispozitiv pentru operații, întreruperi și citire |
| 8 | Separate Reader packaging for local/generic NAS | Pachet Reader pentru local/NAS generic | Root confinement, supported content routes and accessible authenticated connector / Izolare și acces autentificat validate |
| 9 | Extend and monitor retention executors | Extinderea și monitorizarea retenției | TrueNAS 168-hour initial cleanup and Drive sync PASS (8 Oct 2026); observe future automatic runs; local/external safe offline behavior remains planned / Curățarea inițială TrueNAS la 168h și sincronizarea Drive PASS (8 oct. 2026); urmărirea execuțiilor automate viitoare; tratarea offline locală/externă rămâne în plan |
| 10 | Native Windows and Ubuntu acceptance | Acceptarea nativă Windows și Ubuntu | Native install/update/uninstall, credentials and full-batch/content tests / Teste native complete |
| 11 | Evaluate Apple Silicon and supported macOS matrix | Evaluarea Apple Silicon și versiunilor macOS | Native platform results, documented runtime requirements and distribution checks / Rezultate native și cerințe documentate |
| 12 | Universal distribution package | Pachet de distribuție pentru toate platformele | All native platform gates, per-installer checksums and manifests / Validări complete, checksum-uri și manifeste |

Commercial/OEM or hosted-service arrangements remain a separate future track. A third-party code license is distinct from any hosted-service agreement. Free application use is already the owner's distribution policy; it does not establish completion of those future tracks.

Aranjamentele comerciale/OEM sau pentru servicii găzduite sunt o etapă viitoare separată. Licența codului terț nu înlocuiește acordul pentru serviciul găzduit. Utilizarea gratuită a aplicației este politica autorului, fără a însemna că aceste etape viitoare sunt finalizate.
