# The three routes / Cele trei trasee

**Scope:** move managed copies to storage → read selected content in Chat/Work → expire temporary copies. These are separate processes, not one continuous network tunnel.

## A. Mac → NAS: verified upload / Transfer verificat

```mermaid
flowchart TD
 F["Finder: Send to ChatGPT Drop"] --> Q["Private queue, stable frozen batch"]
 Q --> S{"Direct SMB over LAN/private VPN available?"}
 S -->|Yes| L["Direct SMB"]
 S -->|No| T{"Embedded Tailscale peer reachable?"}
 T -->|Yes| P["Private tsnet + loopback SMB proxy"]
 T -->|No| E["STOP: keep staged copies + frozen journal for retry"]
 L --> N["Owner NAS: ChatGPT-Live"]
 P --> N
 N --> V{"Each destination file: BYTES and SHA-256 valid?"}
 V -->|No| E
 V -->|Yes| C["Whole batch READY: clipboard BATCH / PATH / BYTES / SHA256"]
```

Tailscale is a **fallback for Mac upload to the NAS**, not a cloud-to-SMB reading tunnel. Original Finder selections remain untouched. No successful whole-batch verification means no READY.

Tailscale este **rezerva de transport Mac → NAS**, nu un tunel de citire ChatGPT → Samba. Originalele din Finder rămân pe loc.

## B. NAS → Chat or Work: inspect at source / Citirea conținutului

```mermaid
flowchart TD
 C["Paste verified READY manifest in Chat or Work"] --> A{"TrueNAS Reader/MCP available in THIS session?"}
 A -->|Yes| R["Read-only Reader: list batch / ZIP members / bounded chunks"]
 A -->|No| D["Google Drive: ChatGPT Project Bridge"]
 D --> B["Direct traversal: category / date / batch / filename"]
 B --> F{"Exact file visible?"}
 F -->|No| W["If supported, retry direct listing every 30 s until 900 s"]
 W --> B
 W -->|Timeout| X["Stop; report missing level or inaccessible connector"]
 F -->|Yes| G["Check name, BYTES, SHA if exposed"]
 R --> I["Read relevant CONTENT at source"]
 G --> I
 I --> M{"Supported member / range / text read?"}
 M -->|Yes| K["Bring only necessary fragments into model context"]
 M -->|No| Z["Full object transfer only when technically unavoidable"]
 Z --> K
 K --> H["Answer using actual content, not metadata"]
```

**Important:** when translating a `ChatGPT-Live/...` path into the Drive mirror, remove only the leading `ChatGPT-Live/`. Never rely on global search alone. The 30-second/900-second interval is a **requested handoff protocol**; the current Chat, Project, Work or Codex environment may lack timers, a connected Reader, permissions or automated retry capability. Do not claim a background monitor is running unless one exists.

**Atenție:** din PATH eliminăm numai prefixul `ChatGPT-Live/` pentru Drive. `30 s / 900 s` sunt instrucțiuni de handover, nu un cronometru autonom garantat. Lipsa uneltelor/permisiunilor se raportează, nu se inventează conținut.

## C. Temporary storage → deletion / Retenția 7 zile

```mermaid
flowchart TD
 B["UTC timestamp encoded in batch ID"] --> T["Created time + 168 hours"]
 T --> C["TrueNAS scheduled cleaner, every minute"]
 C -->|Expired eligible managed batch| N["Delete only that batch in ChatGPT-Live"]
 N --> S["Trigger Cloud Sync PUSH + SYNC"]
 S --> D["Remove matching files in Google Drive mirror"]
 D --> V["Verify job success and sample source/destination absence"]
```

**Reference deployment, 8 October 2026:** retention cleaner installed, Cron job ID 6 active; initial run removed **31 expired batch directories**; Drive Cloud Sync job reported **SUCCESS**; samples disappeared from source and Drive listings. Historical empty Drive folders may remain. The policy is **not** a backup or guaranteed secure-erasure service. A durable release DMG must be stored **outside** `ChatGPT-Live` because this folder expires its contents after seven days.

**Instalarea de referință:** ștergere inițială verificată, 31 de directoare, job Drive SUCCESS. Backupurile și artefactele permanente stau în altă locație.

## Separate configuration / Configurare independentă

| Layer | Needed and validated separately |
| --- | --- |
| Upload | SMB service/account, atomic writes, destination hash; optional private Tailscale client enrollment |
| Read | TrueNAS Reader mounted `:ro`, secure authorized MCP connection **or** a supported Drive connector |
| Retention | Server-side 168h cleaner; independently configured `PUSH + SYNC` to mirrored Drive folder |

[Setup checklist](SETUP.md) · [Chat/Work handover](HANDOVER.md)
