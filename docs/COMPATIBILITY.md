# Python and platform compatibility / Compatibilitate Python și platforme

Reviewed / Revizuit: **10 October / octombrie 2026**, RC15.1 build 16.

## English

The installer **does not require Homebrew**. It discovers a suitable external **standard CPython 3.14** and creates an application-specific virtual environment using the bundled dependency wheels. It does **not** bundle a standalone Python interpreter. Keep the selected Python installation available: the virtual environment depends on it. Free-threaded/debug Python builds are not supported by this preview's wheel selection.

| Mac setup | Implementation and evidence |
| --- | --- |
| MacPorts only, with standard Python 3.14 | Native tests passed with **MacPorts 3.14.8** on Intel macOS 26.7.1 |
| Official python.org Python 3.14, no Homebrew/MacPorts | Explicit discovery retained; **not natively validated in this session** |
| Homebrew Python 3.14 | Explicit discovery retained; **not natively validated in this session** |
| No suitable external Python | Requirement unmet; installer must stop rather than claim a running engine |
| macOS/system Python alongside application venv | System Python is not replaced or modified; do not assume it is a suitable 3.14 interpreter |

The candidate is **Intel x86_64**, declares **macOS 15** minimum and was tested natively on **macOS 26.7.1**. The minimum declaration is not a completed macOS 15 test. Apple Silicon/Rosetta, Windows and Linux are not validated release targets. Python compatibility does not configure NAS host/share/account, private enrollment, Reader/MCP or retention. A universal setup wizard and local/external destination backends are still unimplemented.

Thus RC15.1 is not certified for “any computer.” It supports discovery of three Python distributions, with native evidence currently limited to MacPorts on the tested Intel Mac. Notarization is a distribution check, not an end-to-end compatibility certificate.

## Română

Installerul **nu depinde de Homebrew**. Caută un **CPython standard 3.14 extern**, apoi creează mediul virtual propriu și instalează dependențele incluse. **Nu conține un interpretor Python autonom.** Python-ul ales trebuie păstrat instalat; mediul virtual depinde de el. Variantele free-threaded/debug nu sunt suportate de selecția de wheel-uri a acestui preview.

- **Mac doar cu MacPorts + Python 3.14:** verificat nativ cu **3.14.8**, Intel macOS 26.7.1.
- **Mac doar cu Python oficial python.org 3.14:** detectarea este implementată și păstrată; nu a fost testată nativ în această sesiune.
- **Mac cu Python Homebrew 3.14:** aceeași limită de validare; Homebrew este opțional.
- **Mac fără Python extern potrivit:** cerința nu este îndeplinită; installerul nu trebuie să declare pornirea motorului.
- **Python-ul macOS:** nu este modificat sau înlocuit; existența lui nu dovedește că satisface cerința 3.14.

Ținta este **Intel x86_64**, cu minim declarat **macOS 15**, testată pe **26.7.1**. Nu certificăm încă macOS 15, Apple Silicon/Rosetta, Windows/Linux sau orice alt calculator. Configurarea SMB, Reader și retenției rămâne separată. Nu există încă wizard universal ori backend de destinație local/extern.

[Installation / Instalare](INSTALLATION.md) · [Tests and limits / Teste și limite](STATUS.md) · [Release](RELEASE.md)
