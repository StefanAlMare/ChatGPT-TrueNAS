# Contractul de implementare — Universal Installer v0.1

**Version context / Context:** RC15.1 repairs startup and credential identity in the existing product. It does not implement this future wizard or change SMB/Tailscale transfer behavior. [Verified scope](STATUS.md) · [Compatibility](COMPATIBILITY.md).

[Pașii utilizatorului](UNIVERSAL_INSTALLER.ro.md) · [Securitate](SECURITY_INSTALLER.md) · [Stocare](HOSTING_AND_STORAGE.md) · [Teste](ACCEPTANCE_INSTALLER.md)

**Document de proiectare, nu executabil.** Codul real rămâne proprietar și privat; nu modificăm RC13/RC14, Private-Work sau repository-ul de profil în această etapă.

## Componente independente

- ClientInstaller: instalare/actualizare, verificare semnături și integrare Finder; Windows/Ubuntu doar după builduri native.
- StorageBackend: o destinație activă, nume dedicat, creare temporară, verificare, commit și retry.
- ReaderProvider: Reader read-only pe TrueNAS, alt NAS Docker ori server permanent.
- ConnectorProvisioner: un singur tunel MCP autorizat sau conector Drive, cu aprobarea utilizatorului.
- RetentionExecutor: planificare, dry-run, ștergere doar în zona administrată și verificare sincronizare.
- MirrorAdapter: copie Drive separată, nu un al doilea canal implicit de upload Mac.

## Mașina de stări

| Stare | Condiție de ieșire |
| --- | --- |
| DISCOVER | OS/CPU și capabilitățile țintelor raportate, read-only |
| PLAN | Utilizatorul a ales storage + reader + retenție |
| APPROVE | Planul exact de modificări/ACL/servicii a fost acceptat |
| PROVISION | Au fost create doar resursele noi aprobate, cu jurnal |
| PROBE_STORAGE | Scriere, citire, rename, BYTES+SHA256 și refuz în afara rădăcinii PASS |
| INSTALL_CLIENT | Binar autentic instalat, starea veche păstrată |
| DEPLOY_READER | Read-only + sandbox + path confinement și test negativ PASS |
| CONNECT | Utilizatorul a autorizat aplicația din ChatGPT, în mediul real |
| CONFIGURE_RETENTION | DRY RUN PASS și acord separat pentru ștergere |
| TEST_E2E | Fișier sintetic transmis și conținut citit din ChatGPT |
| COMMIT_PROFILE | Profil fără secrete activat, raport exportabil |
| ROLLBACK | Revenire reversibilă fără ștergerea originalelor/jurnalului |

Un restart nu repetă operații destructiv; instalarea se reia după jurnalul de operații. Stări funcționale: COMPLETE (toate funcțiile alese trec probe), LIMITED (de exemplu storage-only), BLOCKED (încălcări de securitate, lipsă rută necesară).

## Contractul de stocare

Orice adaptor furnizează funcții echivalente:

1. Probe read-only și verificare a rădăcinii administrate; refuz pentru întregul pool, folder home complet ori căi cu symlink nesigur.
2. Scriere într-un nume temporar per batch; verificare independentă de byte count și SHA256.
3. Commit atomic prin rename pe același filesystem sau manifest final verificat pe obiect storage.
4. Retry/resume exact, cu originalele și jurnalul păstrate la orice eroare.
5. Listare/citire pe fragmente cu limite; retenție disponibilă numai prin executor autorizat separat.
6. Volum extern: UUID/identitate de montare, pauză în lipsa discului, fără scriere în alt volum cu aceeași cale.
7. Drive/WebDAV/S3: protocol specific, OAuth/IAM minim, fără presupunerea unui rename POSIX.

**Invariabil:** READY se emite doar după verificarea întregului lot, nu după simpla deschidere SMB sau disponibilitate Tailscale.

## Contractul profilului

Un profil conține: schema_version, random profile_id, display_name, storage_kind și parametrii fără parole, credential_ref spre secret store-ul OS, reader_kind/reader_ref, mirror_kind și folder_ref, retention TTL/scheduler și last_test_results. O singură destinație poate fi activă. Secretele nu apar în JSON, GitHub, clipboard sau raport.

## Regula securității

- Reader are doar list/find/info/chunks/ZIP-member reads; fără upload, delete, shell ori Docker socket.
- Conturile de upload, Reader, retenție, tunel și cloud sync au privilegii separate.
- Schimbările de ACL, instalarea serviciilor și ștergerile cer afișarea exactă a efectului și acceptare distinctă.
- Nu sunt aprobate porturi SMB publice, chmod -R 777, Docker privileged, chei globale Tailscale sau bypass Gatekeeper.
- Erorile stabile includ STORAGE_ROOT_NOT_SCOPED, SMB_AUTH_FAILED, STORAGE_SHA256_MISMATCH, READER_SCOPE_ESCAPE, CHATGPT_CONNECTOR_UNAVAILABLE, RETENTION_DRY_RUN_REQUIRED, VOLUME_IDENTITY_CHANGED.
- Exportul diagnosticului este redactat: fără parole, tokenuri, chei, date personale și hosturi private.

## Criteriul UI

Fiecare pagină afișează în limbaj accesibil: **Ce facem**, **De ce**, **Ce modificăm**, **Securitate**, **Test**, **Remediere**, **Înapoi/Continuă**. Butonul Continuă se activează numai dacă verificările obligatorii au trecut.

## Garanția de compatibilitate

Capabilitățile au stări distincte: SUPPORTED_AND_TESTED, AVAILABLE_NEEDS_CONFIGURATION, EXPERIMENTAL, PLANNED_NOT_IMPLEMENTED, UNSUPPORTED și BLOCKED_BY_SECURITY. Nu se marchează un NAS, Windows, Ubuntu sau un backend cloud drept SUPPORTED fără teste native.

**Următorul obiect de implementat în sursa privată, după acord separat de editare a acesteia:** configuratorul macOS/TrueNAS cu profil fără secrete, probă SMB în namespace temporar, salvare Keychain și raport de securitate. Fără modificarea transferului RC13/RC14 până la validare independentă.
