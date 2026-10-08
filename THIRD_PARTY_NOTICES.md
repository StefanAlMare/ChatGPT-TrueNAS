# Third-party notices / Componente terțe

The proprietary application license does not replace third-party licenses. The owner authorizes RC14 V8 as a **proprietary non-commercial prerelease**; verify whether a real binary is available under [Releases](https://github.com/StefanAlMare/ChatGPT-TrueNAS/releases). The exact candidate's embedded Tailscale notice is reproduced below and must accompany distribution. Upstream: [Tailscale v1.102.3 license](https://github.com/tailscale/tailscale/blob/v1.102.3/LICENSE).

Licența proprietară a aplicației nu înlocuiește licențele componentelor terțe. Titularul autorizează RC14 V8 ca **pre-release proprietar necomercial**; existența unui fișier se verifică în [Releases](https://github.com/StefanAlMare/ChatGPT-TrueNAS/releases). Mai jos este notificarea Tailscale inclusă în candidat, care trebuie păstrată la distribuție.

## Runtime wheel inventory inspected on 8 October 2026

| Package | Version | License recorded in wheel metadata |
| --- | --- | --- |
| cffi | 2.1.1 | MIT-0 |
| cryptography | 48.0.1 | Apache-2.0 OR BSD-3-Clause |
| jaraco.classes | 3.4.0 | No explicit license field in inspected metadata; consult bundled license |
| jaraco.context | 6.1.2 | MIT |
| jaraco.functools | 4.6.0 | MIT |
| keyring | 25.7.0 | MIT |
| more-itertools | 11.1.0 | MIT |
| platformdirs | 4.11.8 | MIT |
| pycparser | 3.0 | BSD-3-Clause |
| pyperclip | 1.11.0 | BSD (metadata label) |
| pyspnego | 0.12.2 | MIT |
| smbprotocol | 1.17.0 | MIT |

This is an inspected wheel inventory, not a complete transitive software bill of materials. Future repackaging and commercial use require a complete review of Go helper and dependency notices. This inventory is not a complete software bill of materials; independent upstream rights remain in force. The code license and any Tailscale hosted-service agreement are separate matters. No third-party endorsement is implied.

Acesta este inventarul wheel-urilor inspectate, nu lista exhaustivă a tuturor dependențelor tranzitive. Helperul Go, runtime-ul și notificările dependențelor necesită audit complet pentru un nou pachet public. Licența codului și acordul unui serviciu Tailscale găzduit sunt distincte. Nu se pretinde susținerea titularilor.

---

# Third-party notices — embedded Tailscale PoC

This component depends on `tailscale.com` / `tailscale.com/tsnet`, pinned for the current PoC to Tailscale `v1.102.3`.

The upstream Tailscale repository is licensed under the BSD 3-Clause License.

## Tailscale BSD 3-Clause License

Copyright (c) 2020 Tailscale Inc & contributors.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

Upstream license reference for the pinned PoC dependency:
`tailscale/tailscale` tag `v1.102.3`, file `LICENSE`.

This notice must accompany any binary distribution that contains the embedded Tailscale code. It does not grant permission to imply endorsement by Tailscale, and it does not replace review of hosted-service/commercial terms before commercial launch.
