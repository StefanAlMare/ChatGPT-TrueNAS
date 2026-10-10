# Matrice de teste și etape de lansare — Universal Installer

**RC15.1 scope / Domeniu:** notarized startup/Keychain repair, not implementation of this universal-installer design. Twenty isolated repair cases passed; the separate [universal acceptance matrix](ACCEPTANCE_INSTALLER.md) remains a specification. [Current evidence / Dovezi curente](STATUS.md) · [Python requirements / Cerințe Python](COMPATIBILITY.md).

[Ghidul pentru utilizator](UNIVERSAL_INSTALLER.ro.md) · [Stocare și gazde](HOSTING_AND_STORAGE.md) · [Securitate](SECURITY_INSTALLER.md) · [Contractul wizardului](WIZARD_CONTRACT.md)

**Regula de raportare:** PASS este permis **doar** când există rezultat observat pe platforma reală și dovadă suficientă. SPECIFIED, SOURCE_READY, BUILT, INSTALLED și E2E_ACCEPTED sunt lucruri diferite. Pre-release RC15.1 NOTARIZED PREVIEW există, dar un wizard universal funcțional **nu există încă**.

## 1. Milestone-uri distincte

| Etapă | Funcție livrabilă | Intrarea în „gata” |
| --- | --- | --- |
| **M0 — Foundation** | Contract UX, arhitectură pe backenduri, securitate, hosting, teste și explicații | Documente publice complete, linkuri verificate, fără date private sau cod proprietar |
| **M1 — macOS → TrueNAS** | Profil de stocare editabil, dialog host/share/account/folder, Keychain, test SMB, integrare Finder | Teste native pe Mac Intel; păstrarea RC13 baseline; fără presupuneri private în binar |
| **M2 — Reader → ChatGPT** | Pachet Reader autorizat și instalator server read-only, tunnel/conector, test Chat | Confinement și mutații refuzate, conținutul sintetic citit efectiv într-un Chat/Work suportat |
| **M3 — NAS generic / Linux server** | Detectare container vs NAS SMB-only, Reader pe NAS ori gazdă auxiliară | Test pe cel puțin câte un mediu real din fiecare clasă, fără a pretinde suport universal |
| **M4 — disc local / USB extern** | Adaptoare filesystem și volum detașabil, retenție offline | Restart/unplug/replug, refuz volum greșit, commit/hash și Reader/mirror după reatașare |
| **M5 — cloud direct** | Drive, Nextcloud/WebDAV, S3 cu autentificare și commit specific | OAuth/IAM minim, upload resumabil, hash/manifest, conector de citire și lifecycle |
| **M6 — alte OS** | Windows și Ubuntu/ Linux clienți, integrare nativă, certificate/secret store | Install/Update/Uninstall, transfer, conținut citit și retenție E2E **pe fiecare OS** |
| **M7 — pachet universal** | Installer/ZIP distribuit cu pachete **diferite** per OS și manifest | Toate matricile native de securitate și compatibilitate PASS; niciun build incomplet prezentat ca final |

**Țintă imediată:** M1, începând cu profil macOS + TrueNAS și testare sigură, fără schimbarea automată a configurației existente.

## 2. Teste standard pentru orice instalare

| ID | Scenariu de probă | Acceptare |
| --- | --- | --- |
| PRE-01 | OS, arhitectură, versiune incompatibilă | Instalatorul raportează `UNSUPPORTED`; nu schimbă sistemul |
| PRE-02 | ChatGPT nu este instalat | Oferă link oficial/alternativă browser; nu colectează sesiunea OpenAI |
| BIN-01 | Installer/manifest modificat | SHA-256 și/sau semnătura greșite sunt refuzate |
| BIN-02 | Client vechi deja instalat | Update păstrează profilul, Keychain și jurnalul; rollback posibil |
| SMB-01 | Parolă/cont greșit | Eroare clară, fără stocare în log și fără retry nelimitat |
| SMB-02 | Cont cu drepturi numai la managed root | Probe write/read/rename/SHA PASS |
| SMB-03 | Contul poate accesa folder în afara root-ului | **FAIL securitate**; nu activează profilul |
| SMB-04 | Mesaj cu fișier 1 KB | Hash exact la destinație, READY doar după verificare |
| SMB-05 | Mai multe fișiere în același batch | Manifest complet, fără READY parțial |
| SMB-06 | Transfer întrerupt prin scoaterea rețelei | Originalele și jurnalul rămân, reluare exactă |
| SMB-07 | Două calculatoare simultan | Fără coliziune device-id/batch-id și fără dublă comitere |
| SMB-08 | Spațiu insuficient ori share read-only | Eroare și retry sigur, fără ștergerea originalelor |
| TAIL-01 | LAN disponibil | SMB direct; nu impune conectarea Tailscale |
| TAIL-02 | LAN indisponibil, Tailscale autorizat | Upload privat către același NAS, hash/READY valide |
| TAIL-03 | Peer neautorizat | Refuz conexiune; niciun public fallback |
| READ-01 | Reader listează batchul | PATH/BYTES/SHA coincid |
| READ-02 | Reader citește text și ZIP member | Marker real din conținut, nu metadata |
| READ-03 | Reader încearcă scriere/ștergere | Acces refuzat și fără mutații pe dataset |
| READ-04 | Cale `../`, absolută, symlink în afară | Refuz; zero citiri în afara root-ului |
| READ-05 | ZIP bomb sau nume ZIP cu traversal | Refuz/limitare de memorie/timp, fără execuție |
| MCP-01 | MCP autorizat în conversația țintă | Citire reală a markerului în acel Chat/Work |
| MCP-02 | Plan/rol fără MCP | Raportează `UNAVAILABLE`, fără ocolirea politicilor |
| DRIVE-01 | Cloud Sync `PUSH + SYNC` | Fișierul apare în folderul și structura corectă |
| DRIVE-02 | Indexare globală întârziată | Traversarea directă găsește fișierul |
| DRIVE-03 | Scope cloud prea larg, destinat greșit | Cere revizuire/consimțământ; nu activează silent |
| TTL-01 | DRY RUN cu batch vechi artificial | Raportează numai acel lot, nu toate folderele |
| TTL-02 | APPLY autorizat pentru un batch expirat | Șterge doar acel lot și verifică rezultatul |
| TTL-03 | Batch proaspăt sau folder în afara root | Nu se șterge |
| TTL-04 | Drive oglindit și ștergere locală | Jobul de sincronizare e SUCCESS, verificarea copilului fără false negative |
| ROLLBACK-01 | Instalare eșuează la Reader | Revine fără a elimina fișierele/credentialele preexistente |
| UNINST-01 | Uninstall client | Nu șterge automat fișierele NAS, cloud, conturile ori Keys |
| UNINST-02 | Cerere explicită „Delete managed data” | Confirmare separată, dry-run și scope exact |

## 3. Teste speciale după hardware

**TrueNAS:** dataset dedicat, cont SMB limitat, share ACL **și** filesystem ACL, Reader ca Custom App montat `:ro`, fără `privileged`/Docker socket, un singur tunel; retenție server-side și Drive sync; verificare după reboot TrueNAS.

**NAS generic cu Docker:** verificare x86_64/arm64, compatibilitate Docker/OCI, drepturi asupra host path, rețea privată; un NAS fără Docker **nu** este declarat invalid ca stocare SMB, doar Reader-ul necesită altă gazdă.

**NAS generic fără Docker:** export SMB către mini-PC, Reader cu mount read-only; test eșec al gazdei secundare și reconectare fără expunerea portului MCP.

**Linux host:** serviciul Reader revine după reboot, nu are root/`docker.sock`, secretele sunt stocate corespunzător și poate fi revocat independent.

**Mac/PC intern:** permisiunea folderului este limitată; Reader/conectorul este configurat și testat separat de salvarea locală.

**SSD extern:** scoate volumul în timpul transferului, conectează un **alt** disc cu același nume, confirmă refuz; reatașează discul original și reia batchul din jurnal.

**Google Drive direct:** OAuth revocabil, folder dedicat, upload validat, fără access complet la tot Drive când `drive.file` e suficient.

**Nextcloud/WebDAV:** TLS fără bypass, eventual app password, upload chunked, verificare ETag/hash independentă și test de limită de mărime.

**S3:** chei/IAM prefix-limited, multipart/manifest, delete-marker/versioning/lifecycle clar documentate.

## 4. Semnare, distribuție și protecția codului

- Validare Developer ID pe macOS și, înainte de a pretinde compatibilitate de distribuție fără avertismente, notarizare Apple validată. Fără recomandări de dezactivare Gatekeeper.
- Windows: certificat/reputație instalator și test SmartScreen fără dezactivare Defender.
- Ubuntu: verificare integritate/sursă pachet, permisiuni, integrare Secret Service și teste native.
- Reader: imagine oficială specificată prin versiune și digest, scanare dependențe și atestare de integritate.
- Niciun pachet nu are IP/username/chei ale autorului, date personale ori credentiale hardcodate.
- Licență proprietară necomercială; folosirea comercială, distribuirea și reutilizarea sursei necesită acord scris, cu respectarea licențelor terțe.
- Istoricul RC13 rămâne reperul intern acceptat până când noul cod este validat. RC15.1 public rămâne **pre-release**, nu certificare E2E.

## 5. Raportul final de acceptare

```text
PRODUCT                ChatGPT Drop Universal Installer
INSTALLER_VERSION      [versiunea verificată]
PLATFORM               [OS / arhitectura]
STORAGE_PROFILE        [tip backend, fără IP privat]
CLIENT_INSTALL         PASS | FAIL | NOT_IMPLEMENTED
STORAGE_PROBE          PASS | FAIL
TRANSFER_E2E           PASS | FAIL | NOT_TESTED
READER_SCOPE           PASS | FAIL | NOT_CONFIGURED
CHATGPT_CONTENT_READ   PASS | FAIL | CONNECTOR_UNAVAILABLE
CLOUD_FALLBACK         PASS | FAIL | NOT_CONFIGURED
RETENTION              PASS | FAIL | NOT_CONFIGURED
ROLLBACK_TEST          PASS | FAIL | NOT_TESTED
SECRETS_SCAN           PASS | FAIL
OVERALL                COMPLETE | LIMITED | BLOCKED
```

**Definiția COMPLETE:** toate traseele alese și necesare scopului utilizatorului au trecut, inclusiv citirea efectivă a conținutului din ChatGPT dacă acesta este scopul instalării. **LIMITED** poate fi util (doar storage), dar nu este „ChatGPT file-read ready”.

## 6. Ce nu vom considera dovadă

- „Aplicația pornește” **nu** dovedește transfer reușit.
- „Tailscale connected” **nu** dovedește SMB sau SHA.
- „Reader container running” **nu** dovedește că este read-only sau că acest Chat îl poate invoca.
- „Fișierul există în Drive” **nu** dovedește că asistentul îi poate citi conținutul.
- „SHA-256 coincide” **nu** certifică lipsa malware-ului.
- „Cron instalat” **nu** dovedește o ștergere sigură și nici propagarea în cloud.
- „Build compilat” **nu** înseamnă installer universal validat.

## 7. Regula pentru fiecare nou release

Un milestone se închide numai cu: artefact nou și hash, platforme testate, efecte și permisiuni documentate, rezultate negative de securitate, procedură rollback, licențe terțe și documentație actualizată. Nu pornim GitHub Actions și nu atingem repository-uri private sau de profil în cadrul acestui proiect de documentare.
