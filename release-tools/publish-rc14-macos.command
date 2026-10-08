#!/bin/zsh
# SAFETY INTERLOCK — superseded 2026-10-08.
# The original RC14 V8 DMG contains private NAS/SMB/Tailscale defaults.
# Do not publish it. Release must be rebuilt, audited, re-signed and
# its new hash verified before a separate publishing procedure is used.
echo "BLOCKED=ORIGINAL_RC14_DMG_CONTAINS_PRIVATE_INFRASTRUCTURE_CONFIGURATION" >&2
echo "ACTION=CREATE_A_NEW_SANITIZED_AND_SIGNED_ARTIFACT_FIRST" >&2
exit 1
