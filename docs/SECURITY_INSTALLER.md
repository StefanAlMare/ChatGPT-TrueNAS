# Modelul de securitate al Universal Installer — cerințe obligatorii

[Ghid utilizator](UNIVERSAL_INSTALLER.ro.md) · [Gazde și stocări](HOSTING_AND_STORAGE.md) · [Contract tehnic](WIZARD_CONTRACT.md) · [Acceptare și teste](ACCEPTANCE_INSTALLER.md)

**Scop:** protejarea fișierelor utilizatorului, a cheilor de acces și a sistemelor NAS/PC, nu doar obținerea unui mesaj „Install successful”. Acesta este un **model de securitate în proiectare**, nu o certificare deja realizată pentru toate platformele. Aplicăm principiul **fail closed**: lipsa permisiunii, a dovezii de integritate sau a unei configurații necesare blochează acea funcție, fără ocolirea automată a protecțiilor.

## 1. Harta limitelor de încredere

```mermaid
flowchart LR
 X["Fișierele originale, utilizator"] --> F["Client ChatGPT Drop neprivilegiat"]
 F -->|SMB autentificat / VPN privat| N["Folder dedicat pe stocare"]
 F -->|Secrete locale| K["Keychain / Credential Manager / Secret Service"]
 N -->|Montare read-only| R["Reader izolat"]
 R -->|MCP prin tunel securizat autorizat| C["ChatGPT / Work cu drepturi de citire"]
 N -.->|Cloud Sync opțional| D["Drive: copie cloud controlată"]
 D -->|Conector cu drepturi proprii| C
 A["Admin NAS separat"] --> N
 L["Executor retenție separat"] -->|Șterge numai batch-uri expirate| N
```

**Regula centrală:** Reader **nu** primește drepturi de upload, rename, delete, shell, control Docker sau administrare NAS. Executorul de retenție **nu** rulează în Reader; rolurile sunt separate. ChatGPT nu primește prin clipboard parole sau URL-uri private de administrare.

## 2. Model de amenințări și contramăsuri

| Risc / Atac | Control cerut | Ce test negativ trebuie să treacă |
| --- | --- | --- |
| Installer fals/malware | Descărcare sursă oficială, SHA-256, identitate semnatar, notarizare când este disponibilă, digest pentru Reader | Fișier modificat cu 1 octet trebuie refuzat |
| Pachet cu datele dezvoltatorului | Scanare fără date personale, hosturi, useri SMB, token-uri, chei, loguri, certificate private înainte de release | Un artefact cu o adresă/cont de test cunoscut e blocat |
| Cont SMB compromis | Cont dedicat cu acces numai la arborele administrat, fără root/guest | Accesul în afara folderului trebuie refuzat |
| SMB expus public | Port 445 doar LAN/tailnet privat; regula firewall restrânsă | Din exterior fără VPN serviciul nu este accesibil |
| VPN/Tailscale atacat | Autentificare per dispozitiv, ACL/grants stricte, revocare, autentificare MFA/device approval când e posibil | Un peer neautorizat nu ajunge la SMB |
| Scurgere parola prin log/config | Secrete doar în OS vault / Compose secrets / mecanism NAS aprobat, redaction | Logul și profilul JSON nu conțin valori secrete |
| Reader scapă în restul discului | Root confinement, mount `:ro`, interzicere symlink, normalizare/canonizare căi | `../`, symlink spre alt dataset și cale absolută sunt refuzate |
| Parser ZIP malițios | Fără execuție; limite număr membri, adâncime, bytes dezarhivați/ratio, chunk size și timp | ZIP bomb sau nume `../../` este respins |
| Reader exploatat la nivel de container | Proces nonroot, `read_only`, `cap_drop: ALL`, `no-new-privileges`, fără `privileged`/`docker.sock`, resurse plafonate | Nu poate scrie pe host sau porni containere |
| Conector prea puternic | OAuth cu scopes minime, unelte read-only, acces limitat workspace | Fără grant nu există acces, iar un token revocat nu mai merge |
| Drive expune copii | Folder separat, sharing verificat, OAuth limitat, revocare și retenție sincronizată | Un alt utilizator neautorizat nu listează folderul |
| Actualizare pierde fișiere | Jurnal înghețat, backup de stare, migrare versionată, rollback | Update eșuat revine fără ștergerea originalelor |
| Retenție șterge alte date | Prefix/dataset administrat; ID UTC valid, dry-run, fără symlinks, fără wildcard-uri libere | Date în afara arborelui rămân intacte |
| Confuzie hash = sigur | SHA-256 verifică identitatea/integritatea, **nu malware-ul** | Un fișier de test ostil, cu hash corect, nu este declarat sigur |
| Pierderea cheilor / ransomware | Backup separat, versioning/snapshot după decizie și verificare de restaurare | Se poate recupera configurația fără parole în GitHub |
| Device extern dispare | Identitate volum/UUID, jurnal local, PAUSED, remount verificat | Nu scrie accidental în folderul cu aceeași cale pe alt disc |

## 3. Conturi, privilegii și roluri

### Conturi independente

1. **Utilizatorul ChatGPT:** identitate personală/workspace în ChatGPT. Se autentifică la OpenAI; **installerul nostru nu cere și nu stochează parola sau codul 2FA**.
2. **Utilizatorul clientului local:** cont normal macOS/Windows/Linux; operații de transfer fără root. Admin doar pentru instalare și înregistrare OS când necesar.
3. **Contul SMB:** utilizator nou cu permisiuni de create/read/rename în folderul administrat; nu utilizator admin, nu guest.
4. **Identitatea Reader:** numai **citire și traversare** în folderul administrat; ACL și mount trebuie să blocheze orice mutație.
5. **Identitatea executorului de retenție:** poate șterge exclusiv batchurile aprobate din namespace-ul administrat; nu are cheile ChatGPT și nu expune comenzi MCP.
6. **Identitatea tunelului MCP:** doar serviciul Reader, fără drepturi de administrare NAS sau acces la alte aplicații.
7. **Identitatea Cloud Sync:** drepturi numai la directorul local și folderul cloud dedicat; nu cont de administrator al întregului Drive dacă există o variantă mai restrictivă.

### Acțiuni administrative

Instalarea Reader pe TrueNAS, modificarea ACL, instalarea serviciilor sau ștergerea dataseturilor **nu se execută automat** printr-o simplă bifă. Fiecare operație cu efect pe server trebuie afișată înainte în planul de schimbare, cu calea exactă, utilizatorul, versiunea, efectul, verificarea și reversibilitatea.

**Fără** activare implicită a `sudo nopasswd`, `privileged Docker`, expunere porturi WAN ori `chmod -R 777`.

## 4. Secrete și autentificare

**Pe macOS:** Keychain, per profil; **Windows:** Credential Manager; **Ubuntu/Linux desktop:** Secret Service / GNOME Keyring când disponibil. Server Linux: fișiere de secrete cu permisiuni restrictive ori backend secret manager; pentru Docker Compose folosește mecanismul `secrets` când containerul suportă. TrueNAS: depozitarea aprobată pentru credentiale cloud și aplicații.

**Interzise:** parole în URL `smb://user:password@...`, variabile într-un README public, profile `.json`, clipboard handover, issue GitHub, jurnale. Tokenuri OAuth, chei Tailscale și Apple signing private key nu intră în pachete publice.

**Tailscale:** chei per dispozitiv, de unică folosință când potrivit, device approval și ACL/grants restrictive; revocarea key-ului de înrolare nu înseamnă automat revocarea nodului deja înscris — dezactivarea nodului se face separat. Pentru distribuție comercială a serviciului încorporat, verifică distinct condițiile hosted-service/OEM.

**Google Drive:** folosește OAuth 2.0 și scopes cât mai înguste (de exemplu `drive.file` dacă funcționalitatea se încadrează); utilizatorul autorizează în browser. Un serviciu cloud care necesită scopes largi este semnalat și cere confirmare explicită. Nu folosim credentiale Google comune pentru toți utilizatorii.

## 5. Separarea rețelelor

**Mac → NAS:** SMB direct doar local/privat. Dacă nu merge, nodul embedded Tailscale poate transporta **tot SMB** către aceeași destinație, cu proxy numai în loopback. Nu folosim public Funnel/zrok/SFTP ca mecanisme de upload implicit, deoarece au fost trasee experimentale abandonate în arhitectura curentă.

**NAS → ChatGPT:** Reader rulează în spatele unui tunel MCP securizat sau altă integrare oficial compatibilă, **nu prin expunerea la internet a portului 8000/445**. Accesul de la ChatGPT necesită autorizație distinctă față de accesul SMB. Conectorul Drive este alt domeniu de încredere, cu alte drepturi.

**TLS:** validarea certificatelor rămâne activă. Certificatele auto-semnate se tratează prin lanț de încredere verificat, niciodată prin `verify=false` sau `curl -k` folosit ca remediere permanentă.

## 6. Configurația securizată a containerului Reader

Obiectivul minim:

- utilizator neprivilegiat, fără root când permite imaginea;
- montarea datasetului exclusiv `/data:ro`, fără acces la alte căi NAS;
- filesystem read-only, `tmpfs` limitat pentru cache temporar;
- `cap_drop: [ALL]`, `no-new-privileges`, fără `privileged`;
- fără volume `/var/run/docker.sock`, fără dispozitive speciale, fără network host implicit;
- portul MCP accesibil numai de tunelul aprobat, nu de întreaga rețea LAN și nu din internet;
- imagine Reader fixată la versiune/digest verificabil, actualizare controlată;
- limiter de timp, memorie, CPU, număr procese și dimensiune răspuns pentru arhive;
- API limitată la funcții read-only precum list, find, info, text/chunk și ZIP-member info/chunk.

**Controlul real necesită atât** volumul `:ro` **cât și** UID/GID/ACL fără drept de scriere la nivel host. Un simplu buton „read-only” în interfață nu este suficient dacă procesul are altă cale de modificare a datelor.

## 7. Procesarea fișierelor și jurnalul

- Batch ID cu timestamp UTC, identitate persistentă random per dispozitiv și sufix anti-coliziune; inputuri stabilizate și jurnal înghețat înainte de upload.
- Upload în nume temporar, promovare/commit doar după verificare independentă BYTES + SHA-256 la destinație.
- Întreruperea păstrează jurnalul și copiile locale; reluarea exact a aceluiași batch, fără duplicare.
- READY și clipboard apar doar după verificarea **întregului lot**.
- Mesajul din clipboard conține cale, dimensiune, SHA, identificator, nu secrete. Chiar și **numele fișierelor/căile pot fi sensibile** și vor fi tratate ca date personale.
- Reader limitează dimensiunile, întoarce numai fragmente utile pentru analiză; nu deschide arhive prin executarea lor.
- Pentru stocări obiect (S3), „commit atomic” înseamnă un **manifest final valid**, nu un rename POSIX care poate să nu existe.

## 8. Ștergerea la 7 zile ≠ ștergerea sigură definitivă

Există trei noțiuni diferite:

1. **Retenție logică în arborele administrat:** ștergem batchurile expirate după 168h.
2. **Oglindă Drive:** taskul `PUSH + SYNC` propagă ștergerea, dar pot exista coș de gunoi, istoric de versiuni și întârzieri.
3. **Backupuri/snapshoturi/cloud versioning:** pot păstra datele mai mult; sunt gestionate printr-o politică diferită.

Wizardul va arăta utilizatorului această diferență. Nu va promite *secure erase*, conformitate GDPR automată sau dispariția oricărei copii din servicii terțe. Retenția nu trebuie activată fără dry-run și acceptarea explicită a riscului ștergerii.

## 9. Supply chain, semnare și actualizări

**macOS:** semnare Developer ID validă și verificarea notarizării/staplingului unde este disponibilă. **Nu dezactivăm Gatekeeper** ca parte a procedurii.  
**Windows:** pachet semnat, reputație/SmartScreen tratată transparent; nu dezactivăm Defender.  
**Linux:** pachet din sursă verificată, digest, semnături și gestionare nativă prin sistemul de pachete unde e fezabil.  
**Reader:** container image identificat prin digest, licențe/avize terțe, audit de dependențe înainte de release.

Publicarea unui nou DMG modificat cere SHA-256 **nou** și semnătură validă. Sursa proprietară nu se publică în repository-ul public. Codul Python lizibil într-un pachet nu reprezintă permisiune de reutilizare, însă **nu este o protecție tehnică împotriva copierii**.

## 10. Afișarea și exportul raportului de securitate

La final wizardul arată:

```text
Client signature           PASS / FAILED
Platform security          PASS / NEEDS_USER_ACTION
Storage account privilege  PASS / FAILED
Storage containment        PASS / FAILED
Upload checksum            PASS / FAILED
Reader read-only test      PASS / NOT_CONFIGURED / FAILED
Reader outside-root test   PASS / FAILED
MCP authorization          PASS / NOT_AVAILABLE
Drive folder ACL           PASS / NOT_CONFIGURED
Retention dry-run          PASS / NOT_CONFIGURED
Backup warning accepted    YES / NO
Secrets leaked to logs     NONE_FOUND / FAILED
Overall                    COMPLETE / LIMITED / BLOCKED
```

Exportul nu conține parole, chei, tokenuri, căi personale sau fișiere ale utilizatorului. Informații sensibile pot fi colectate numai pentru depanare, după acord explicit și **redactare locală**.

## 11. Condiții de oprire fără negociere

Installerul se oprește înainte de a activa profilul dacă găsește unul dintre următoarele: folosirea contului root/guest pentru SMB; Reader cu drept de ștergere; port SMB expus WAN fără tunel privat; imagine Docker neidentificată; certificat nevalid fără soluție de încredere; secret în sursă/config/log; jurnal sau batch într-o destinație cu identitate incertă; ștergere care traversează rădăcina administrată; profil pentru care nu se poate face o verificare de integritate independentă.

**Diferența dintre moduri:** pentru un utilizator care dorește numai stocarea locală fără citire ChatGPT, rezultatul poate fi `LIMITED — upload only`; pentru scopul principal al produsului, lipsa unei rute de citire reale în ChatGPT nu este `COMPLETE`.

### Surse tehnice folosite la definirea politicii

- [OpenAI: MCP apps, developer mode și Secure MCP Tunnel](https://help.openai.com/en/articles/12584461-developer-mode-and-full-mcp-connectors-in-chatgpt)
- [TrueNAS: Custom Apps](https://apps.truenas.com/managing-apps/installing-custom-apps/) și [SMB 25.10](https://www.truenas.com/docs/scale/25.10/scaletutorials/shares/smb/)
- [Docker Compose: non-root, read-only, cap_drop, no-new-privileges](https://docs.docker.com/reference/compose-file/services/) și [Compose secrets](https://docs.docker.com/compose/how-tos/use-secrets/)
- [Tailscale: best practices](https://tailscale.com/docs/reference/best-practices/security) și [auth keys](https://tailscale.com/docs/features/access-control/auth-keys)
- [Google Drive OAuth: least-privilege scopes](https://developers.google.com/workspace/drive/api/guides/api-specific-auth)
