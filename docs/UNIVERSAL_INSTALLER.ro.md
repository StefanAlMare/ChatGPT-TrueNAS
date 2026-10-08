# Asistent universal de instalare — ghidul utilizatorului (proiectare v0.1)

[English](UNIVERSAL_INSTALLER.md) · [Stocare și servere](HOSTING_AND_STORAGE.md) · [Securitate detaliată](SECURITY_INSTALLER.md) · [Contract tehnic](WIZARD_CONTRACT.md) · [Teste și plan](ACCEPTANCE_INSTALLER.md)

> **Stare la 8 octombrie 2026:** acesta este **fluxul pe care îl construim**, NU un installer universal disponibil deja. Release-ul public [RC14 V8 SANITIZED](https://github.com/StefanAlMare/ChatGPT-TrueNAS/releases/tag/v0.9.0-rc14) este un pre-release Intel macOS, încă fără asistent general de configurare și fără acceptare E2E finală. Reader-ul nu este distribuit încă drept pachet instalabil pentru public.

## Ce vrem să obținem

Un utilizator fără cunoștințe de rețelistică trebuie să poată ajunge, în mod ghidat, de la **ChatGPT pe calculator** la:

1. **ChatGPT Drop** instalat și semnat corect;
2. o **destinație de stocare administrată** — TrueNAS, alt NAS SMB, un calculator/server permanent pornit, disc intern sau extern, ori cloud;
3. o **rută de citire pentru ChatGPT** — Reader/MCP cu acces strict de citire sau conector cloud disponibil;
4. o **politică de retenție și securitate**, explicit acceptată;
5. un **test real cap-coadă** și un raport fără parole.

**Motivație:** evitarea încărcărilor integrale repetate de arhive în ChatGPT. Fișierele ocupă în continuare spațiu pe stocarea aleasă; conținutul adus la analiză consumă context/tokens și apeluri de instrumente. Acest produs nu elimină cotele ChatGPT și nu promite acces la orice conector pe orice abonament.

## Ce instalează efectiv produsul

- **ChatGPT (aplicația oficială sau browser):** produs extern. Asistentul furnizează linkuri oficiale și verifică disponibilitatea, **nu descarcă din surse neoficiale, nu instalează aplicația fără acord și nu colectează parola ChatGPT**.
- **ChatGPT Drop (clientul nostru):** aplicație separată, care pregătește loturile, le transferă și produce handover-ul. Este componenta pe care o putem instala/configura direct.
- **ChatGPT Reader (server):** componentă separată, exclusiv pentru citire, care poate funcționa pe NAS sau pe o gazdă de încredere. Nu se instalează obligatoriu pe fiecare calculator client.
- **Connector/tunel:** puntea prin care un Chat/Work autorizat poate folosi Reader-ul. Necesită operații de conectare și aprobare realizate de utilizator în ChatGPT.
- **Curățare automată:** independentă de client și de Reader; poate rula pe server, pe gazda locală sau numai când revine dispozitivul detașabil.

## Parcursul utilizatorului: 12 ecrane, fiecare cu „De ce?”, „Acțiune”, „Verificare”, „Securitate”

### 0. Verificare inițială — fără modificări

**De ce:** evităm instalări incompatibile sau conectări către un NAS care nu aparține utilizatorului.

**Acțiune:** detectăm sistemul (macOS/Windows/Linux), arhitectura, versiunea, conexiunea locală, drepturile utilizatorului și spațiul disponibil; întrebăm doar dacă dorește ChatGPT în browser sau aplicație, tipul stocării și dacă are acces administrativ la ea. Niciun scan agresiv al rețelei.

**Verificare:** afișăm explicit componentele compatibile, cele experimentale și cele indisponibile. Nu presupunem că macOS patch-uit ori hardware neoficial este suportat automat.

**Securitate:** numai verificări read-only, fără privilegii root și fără a trimite inventarul calculatorului în cloud.

### 1. ChatGPT oficial — instalare sau autentificare

**De ce:** utilizatorul trebuie să aibă un mediu ChatGPT în care va lipi mesajele și, la nevoie, va conecta Reader/Drive.

**macOS:** deschide [chatgpt.com/download](https://chatgpt.com/download/) și alege installerul oferit oficial pentru Intel sau Apple Silicon; versiunea desktop actuală necesită macOS 14+. Semnătura și sursa trebuie verificate prin mecanismele sistemului. **Nu dezactiva Gatekeeper**.

**Windows:** instalează ChatGPT din sursa oficială/Microsoft Store, compatibilitatea depinzând de versiunea Windows și politicile IT.

**Linux:** folosește [chatgpt.com](https://chatgpt.com) în browser; nu prezentăm un pachet desktop Linux terț ca fiind aplicația oficială OpenAI.

**Verificare:** autentificarea se face direct la OpenAI, fără ca ChatGPT Drop să vadă parola ori codurile MFA. Se deschide o conversație.

**Securitate:** verificarea în doi pași se realizează în mecanismul oficial; nu stocăm cookie-uri, sesiuni sau token-uri OpenAI.

### 2. Clientul ChatGPT Drop — instalare/actualizare

**De ce:** o selecție de fișiere în Finder/Explorer/file manager trebuie să producă un lot verificat, nu o copie incompletă.

**Acțiune:** descarcă numai release-uri oficiale; verifică dimensiunea și SHA-256 din manifest, semnătura platformei și starea de notarizare/publicare. Arată clar licența proprietară necomercială înainte de instalare. Pentru macOS folosește installerul grafic, iar celelalte sisteme vor avea pachete native numai după validare separată.

**Verificare:** aplicația pornește; acțiunea Finder apare în Quick Actions; pe Windows și Linux integrarea este marcată *planificată*, nu *funcțională* până la test nativ.

**Securitate:** privilegiile administrative numai pentru copiere/înregistrare, niciodată pentru serviciul normal de transfer; nu suprascrie datele sau Keychain la Update.

### 3. Unde păstrăm fișierele? — alegerea profilului de stocare

**De ce:** nu orice persoană are TrueNAS și nu orice NAS poate rula un container.

Utilizatorul alege **o singură destinație activă**:

| Alegere | Ce configurăm | Stadiu |
| --- | --- | --- |
| TrueNAS SCALE | Dataset/folder, cont SMB, share, Reader ca aplicație izolată, opțional Cloud Sync | Referință funcțională, dar wizard general de construit |
| NAS obișnuit cu SMB (Synology, QNAP, ASUSTOR etc.) | Share, cont limitat, Reader pe NAS dacă există containere sau pe altă gazdă | De implementat și testat pe modele |
| Server Linux / mini-PC / alt calculator | Folder administrat + SMB sau backend local + Reader containerizat | De implementat și testat |
| Folder de pe discul intern | Folder dedicat + Reader pe o gazdă accesibilă sau oglindă cloud | Backend local încă neimplementat în RC14 |
| SSD/HDD extern / USB | Identitatea volumului, folder, jurnal/retention rezilient la deconectare | Backend extern încă neimplementat |
| Google Drive / Nextcloud / WebDAV / S3 | Profil cloud cu OAuth/token limitat și citire compatibilă | Direcție viitoare; nu pretindem că RC14 poate scrie direct acolo |

**Verificare:** o destinație are nume unic, cale explicită, spațiu disponibil și identitate stabilă. Instalarea într-un volum existent nu modifică alte foldere.

**Securitate:** nu acceptăm rădăcina sistemului, întregul pool, `/`, folderul personal complet sau un share folosit pentru backup, fără delimitare administrată. Se cere folder dedicat.

### 4. Conectarea și drepturile de scriere

**De ce:** un lot trebuie să poată fi creat și verificat fără ca aplicația să obțină acces la întregul NAS.

**Acțiune:** utilizatorul indică host/share/folder și un **cont SMB dedicat**; pe alt backend, alege folderul/bucketul cu permisiuni limitate. Parola se introduce numai prin dialogul local securizat și se păstrează în Keychain/Credential Manager/Secret Service. Nu scriem parola în JSON, log, clipboard sau GitHub.

**Verificare:** într-un subfolder temporar aleator generat de installer, testăm creare, scriere, listare, citire, redenumire atomică, SHA-256 și ștergerea **doar a propriului fișier de probă**. Orice pas nereușit blochează activarea profilului. Nu efectuăm curățări recursive ale folderelor existente.

**Securitate:** cont separat, fără administrare a NAS-ului; ACL permis numai în arborele administrat; niciodată SMB guest sau root. Portul 445 rămâne în LAN/rețea privată, nu expus direct în internet.

### 5. Acces de la distanță — opțional

**De ce:** dintr-un hotel/hotspot, LAN SMB poate deveni inaccesibil.

**Acțiune:** implicit funcționează **SMB direct**. Dacă utilizatorul permite transport privat, se configurează identitate Tailscale/tsnet **per instalare**, autentificată în propriul tailnet. Se testează separat ruta către același server SMB, fără server SMB public.

**Verificare:** transferul unui lot de probă atât în LAN, cât și în afara LAN (când utilizatorul poate testa). Conexiunea la Tailscale nu este echivalentă cu un batch READY.

**Securitate:** nu includem cheie Tailscale comună în installer; acl/grants restrânse la destinatarul necesar; revocarea unei instalări trebuie posibilă fără dezactivarea întregii rețele.

### 6. Unde va funcționa Reader-ul?

**De ce:** ChatGPT din cloud nu vede automat fișierele de pe un disc local sau un SMB privat.

**Acțiune:** dacă TrueNAS/NAS oferă containere, instalăm Reader **pe acel server**; altfel îl instalăm pe un Linux/mini-PC de încredere, cu acces read-only la folderul administrat. Pentru disc intern/extern, Reader local ori oglinda Drive sunt variante de proiectare. Dacă nu există Reader compatibil, alegem o rută cloud de citire disponibilă.

**Verificare:** Reader vede numai rădăcina administrată, poate lista batchuri, poate citi text și membri ZIP și **nu poate crea, șterge, redenumi sau executa comenzi**.

**Securitate:** container neprivilegiat, montare `:ro`, filesystem read-only, capabilități reduse, fără Docker socket, cu limite de memorie, CPU și dimensiune răspuns.

### 7. Conectarea Reader → ChatGPT

**De ce:** prezența Reader-ului pe NAS nu dovedește că această conversație îl poate accesa.

**Acțiune:** se configurează **un singur serviciu/tunel securizat pe gazda Reader**, numai pe o cale suportată oficial. Utilizatorul aprobă aplicația/MCP în propriul cont sau workspace ChatGPT. Dacă planul/rolul nu permite custom MCP, installerul explică limita și oferă opțional ruta Drive; nu recomandă ocolirea controalelor workspace.

**Verificare:** în **aceeași conversație** unde se vor folosi fișierele, se citește conținutul unui fișier text de probă, nu doar metadata.

**Securitate:** legătura e autorizată, instrumentele sunt exclusiv read-only, accesul se poate revoca, iar utilizatorul vede precis ce surse sunt conectate. Nu exportăm un token MCP în mesajele din clipboard.

### 8. Alternativa Google Drive — numai dacă este aleasă

**De ce:** Reader/MCP poate lipsi din Chat/Work sau poate fi indisponibil temporar.

**Acțiune:** pentru TrueNAS, se configurează opțional **Cloud Sync PUSH + SYNC** către folderul dedicat `ChatGPT Project Bridge`. Pentru un backend Drive direct va fi necesar un adaptor separat, cu OAuth și permisiuni minime. Nu cerem acces de administrare la toate fișierele din Drive când poate fi folosit un scope limitat.

**Verificare:** fișierul de probă apare în arborele `categorie/dată/batch`; ChatGPT îl identifică prin traversare directă și **îi citește conținutul**. Un search global gol nu este dovada lipsei fișierului.

**Securitate:** utilizatorul este avertizat că există **o a doua copie în cloud** și vede cine are acces la folder. Dacă sincronizarea ștergerilor e necesară, verificăm modul `SYNC`, nu presupunem că `COPY` șterge destinația.

### 9. Retenția — alegerea explicită

**De ce:** batchurile sunt copii de lucru, nu backup permanent.

**Acțiune:** opțiuni: fără ștergere, 24h, 3 zile, **7 zile (propunere implicită)**, 30 de zile, interval personalizat. Vârsta se calculează din ID/manifest UTC al batchului, nu exclusiv din mtime. Pentru TrueNAS folosim componenta server-side, pentru un volum extern este obligatorie amânarea sigură când discul lipsește.

**Verificare:** simulare `DRY RUN`; apoi numai cu acord explicit o probă expirată, delimitată, urmată de verificarea ștergerii și a sincronizării Drive. La referința TrueNAS prima curățare reală din 8 octombrie 2026 a eliminat 31 de batchuri expirate; nu înseamnă că orice NAS are retenția instalată.

**Securitate:** protejăm toate datele din afara arborelui administrat; refuzăm symlink, path traversal, timestamp nevalid și ștergerea unui folder cu nume neconform. Oglinzile/snapshoturile/backupurile pot păstra copii mai mult timp decât TTL.

### 10. Testul complet de funcționare

**De ce:** „program instalat” nu înseamnă „sistem complet”.

**Acțiune:** generăm un fișier text de probă, fără date personale, și îl trimitem cu integrarea platformei. Instalatorul verifică transferul, hashul și starea READY. Mesajul este lipit în ChatGPT, iar Reader sau Drive trebuie să citească exact un marker din conținut.

**Verificare:** raport separat pentru `CLIENT`, `STORAGE`, `TRANSFER`, `READER`, `CHAT_CONTENT`, `RETENTION`, `REMOTE_ACCESS`, fiecare PASS / FAILED / NOT_CONFIGURED / NOT_TESTED. „INSTALARE COMPLETĂ” numai dacă toate funcțiile activate și necesare au trecut.

**Securitate:** testele folosesc date sintetice, fără exportul inventarului personal sau al credentialelor.

### 11. Finalizare, recuperare și dezinstalare

**De ce:** trebuie să putem reveni după o instalare nereușită fără pierderi.

**Acțiune:** salvăm un profil fără secrete, punctele de recuperare, versiunea, identitatea serverului și testele. Installerul explică Start at Login/Update, oprirea serviciilor și dezinstalarea. Separa **Uninstall App**, **Disconnect Connector**, **Remove Credentials**, **Remove Reader**, **Delete Managed Data** în acțiuni independente.

**Verificare:** rollback/Update păstrează datele și credentialele dacă utilizatorul nu a cerut ștergerea lor. Nu ștergem automat un dataset NAS la dezinstalare.

**Securitate:** la „Delete managed data” solicităm identificarea explicită a destinației și o confirmare separată, niciodată ștergere printr-un buton generic.

## Rezultatul vizibil la final

```text
ChatGPT installation   : PASS / BROWSER / UNSUPPORTED
ChatGPT Drop client    : PASS / NOT_AVAILABLE_FOR_THIS_OS
Storage destination    : PASS
Verified upload        : PASS
Reader/MCP             : PASS / NOT_CONFIGURED / UNAVAILABLE_IN_THIS_CHAT
Google Drive fallback  : PASS / NOT_CONFIGURED
Retention              : PASS / NOT_CONFIGURED
Remote Tailscale       : PASS / NOT_CONFIGURED
Complete content read  : PASS / BLOCKED

Configuration readiness: COMPLETE / LIMITED / BLOCKED
```

**Regulă de proiect:** nu confundăm *transportul*, *citirea* și *retenția*. Fiecare are validări și permisiuni separate. Nu vom rescrie baseline-ul intern RC13 sau declara RC14 E2E validat doar din documente. Nu publicăm surse proprietare și nu modificăm repository-urile de profil ori cele private în această etapă.
