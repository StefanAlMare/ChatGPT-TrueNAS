# ChatGPT Drop · ChatGPT-TrueNAS

**Loturi de fișiere verificate, din Finder în stocare, cu un mesaj precis pentru ChatGPT.**

[English](README.md) · [Instalare](docs/INSTALLATION.md) · [Arhitectură](docs/ARCHITECTURE.md) · [Istoric](HISTORY.md) · [Stadiu](docs/STATUS.md) · [Roadmap](docs/ROADMAP.md)

**ChatGPT Drop** este aplicația pentru Apple/macOS. **ChatGPT-TrueNAS** este repository-ul public de documentație și distribuție, administrat de [StefanAlMare](https://github.com/StefanAlMare).

Aplicația grupează fișierele selectate într-un lot stabil, le transferă pe TrueNAS prin SMB, verifică numărul de octeți și hash-ul SHA-256 la destinație și pregătește un mesaj în clipboard care identifică exact fișierele pentru ChatGPT. Conținutul poate fi citit prin serviciul Reader/MCP, exclusiv pentru citire, sau printr-o oglindă Google Drive configurată separat.

## Disponibilitate și stadiul real

| Element | Stadiu |
| --- | --- |
| Ultimul candidat | **ChatGPT Drop 0.9.0-rc14 V8**, build 14 |
| Build nativ, semnare și audit al DMG-ului final | PASS consemnat pe macOS Intel, 12 septembrie 2026 |
| Update grafic și utilizare completă RC14 V8 | **Încă nevalidate** |
| Versiunea internă macOS acceptată | RC13, inclusiv transfer din afara LAN și citirea conținutului prin Drive, validate de utilizator |
| Installer public | **Nepublicat: DMG-ul exact, verificat prin hash, conține sursă Python proprietară** |
| GitHub Release | **Niciun release publicat**, conform cerinței actuale de a nu publica sursele |
| Folder local / disc extern | Planificate; adaptoarele nu sunt implementate |
| Alte dispozitive NAS SMB | Direcție arhitecturală; fără validare proprie de compatibilitate |
| Windows / Ubuntu / build nativ Apple Silicon | Nevalidate pentru distribuție publică |

Stadiu revizuit la **8 octombrie 2026**, pe baza înregistrărilor dezvoltării. Rezultatele istorice PASS se referă la mediul testat atunci; nu reprezintă teste complete RC14 refăcute acum. Consultă [matricea de validare](docs/STATUS.md) și [identitatea installerului](docs/RELEASE.md).

## Aplicație gratuită, surse private și proprietare

**Oricine poate utiliza gratuit aplicația compilată distribuită oficial, inclusiv în scop personal sau profesional.** Codul-sursă rămâne proprietar și privat. Folosirea, modificarea sau redistribuirea surselor proprietare necesită **permisiunea scrisă prealabilă a lui StefanAlMare**. Repository-ul nu acordă o licență open-source.

[Licența](LICENSE.md) separă utilizarea gratuită a aplicației de drepturile asupra surselor. Componentele terțe își păstrează propriile licențe. Conturile externe, stocarea, conectivitatea și eventualele costuri ale serviciilor sunt separate de licența gratuită a aplicației.

## Cum funcționează

1. Selectezi fișiere obișnuite în Finder și alegi **Quick Actions → Send to ChatGPT Drop**.
2. Acțiunea copiază fișierele într-o coadă ascunsă. Originalele selectate în Finder rămân pe loc.
3. După stabilizarea intrărilor, clientul îngheață lotul, folosind o identitate persistentă a dispozitivului și un identificator de lot rezistent la coliziuni.
4. Preferă SMB direct în LAN sau într-o rețea privată accesibilă. Din afara LAN, arhitectura RC13 folosește un helper Tailscale/tsnet integrat și un proxy accesibil numai local, spre aceeași destinație SMB.
5. Scrierile temporare, verificarea octeților și SHA la destinație și jurnalul persistent protejează reluarea transferului. READY și mesajul din clipboard apar după verificarea întregului lot.
6. Lipești mesajul într-un mediu ChatGPT cu Reader sau conector Drive disponibil. Accesul la conținut depinde de acel mediu și de permisiunile sale.

Structura activă este `ChatGPT-Live/<categorie>/<dată>/<id-lot>/<fișier>`. Categoriile își păstrează numele: `Poze`, `Documente`, `Loguri`, `Arhive`, `Video`, `Audio`, `Diverse`.

Protocolul din clipboard al RC14 V8 cere căutare imediată prin Reader, traversare directă imediată în Drive dacă Reader nu este disponibil, apoi reluare la fiecare **30 de secunde**, timp de cel mult **900 de secunde** de la prima încercare. Cere inspectarea conținutului la sursă și transferul integral numai când este necesar. Acestea sunt instrucțiuni transmise asistentului, nu o garanție că orice mediu ChatGPT le execută automat. [Detalii despre protocol](docs/PROTOCOL.md).

## Instalare și prima utilizare

Candidatul exact a fost recuperat și verificat prin hash, dar nu este disponibil public deoarece include sursă proprietară. Dacă distribuirea este autorizată, punctul de intrare prevăzut este **ChatGPT Drop Installer.app**, cu **Install**, **Update** și **Uninstall**. Instalarea în `/Applications` solicită autorizarea obișnuită de administrator macOS. Update-ul RC14 rămâne de validat.

Candidatul actual este pentru **macOS Intel x86_64** și provine dintr-o instalare internă. Nu este încă un installer universal, configurabil complet pentru orice cont NAS: setările specifice destinației necesită adaptare și testare de către autor. Meniul parolei SMB nu reprezintă un asistent complet de configurare a stocării.

[Ghidul de instalare](docs/INSTALLATION.md) explică pregătirea TrueNAS, utilizarea pe Mac, accesul privat la distanță, cerințele pentru un NAS SMB obișnuit și planul pentru stocare locală. Instalarea Reader necesită un pachet autorizat furnizat separat; repository-ul public nu conține implementarea serverului sau o imagine de container.

## Protecția transferului

- Fișierele locale pregătite și jurnalul înghețat sunt păstrate la erori de transfer.
- READY înseamnă că lotul a fost verificat; nu înseamnă că ChatGPT a citit deja fișierele.
- Parolele SMB și datele de înrolare Tailscale se păstrează în macOS Keychain.
- TrueNAS este stocarea autoritativă; Google Drive este o oglindă pentru citire.
- Reader permite numai citirea în rădăcina configurată și respinge ieșirea prin legături simbolice.
- Experimentele publice HTTPS/Funnel/zrok/SFTP sunt istorice și nu fac parte din arhitectura actuală de transfer.

[Arhitectură și limite de încredere](docs/ARCHITECTURE.md) · [Securitate și suport](SECURITY.md)

## Dezvoltare și participare

[HISTORY.md](HISTORY.md) urmărește proiectul de la prototipul din septembrie 2026, prin toate etapele RC numerotate, până la RC14 V8, inclusiv candidații eșuați și înlocuiți. [Roadmap-ul](docs/ROADMAP.md) prioritizează validarea RC14, pregătirea distribuției publice, profilurile de stocare și testele native. Istoricul Git public începe cu această publicare a documentației; nu reconstituie și nu expune istoricul Git privat.

Folosește [Issues](https://github.com/StefanAlMare/ChatGPT-TrueNAS/issues) pentru rapoarte fără date private, corecturi și propuneri. Contribuțiile la surse și accesul la surse necesită permisiune scrisă. Nu sunt incluse workflow-uri GitHub Actions.

ChatGPT, OpenAI, Apple, TrueNAS, Google Drive și Tailscale aparțin titularilor respectivi. Proiectul nu pretinde sponsorizarea sau susținerea acestora.
