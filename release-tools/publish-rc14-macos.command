#!/bin/zsh
set -euo pipefail
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

REPO="StefanAlMare/ChatGPT-TrueNAS"
TAG="v0.9.0-rc14"
NAME="ChatGPT-Drop-Installer-macOS-x86_64-0.9.0-rc14.dmg"
BYTES="23092580"
SHA="125802a96df9b169960ed09f65cdb893b22f85f1875d285ea67b942a9b3c6f34"
REL="ChatGPT-Live/Arhive/2026-10-08/20261008T173628Z-dvd533eeec-f989e693"
ARCHIVE="$HOME/Downloads/ChatGPT-Drop-Releases"
TEMP="$(mktemp -d /tmp/chatgpt-drop-release.XXXXXXXX)"
MOUNT="$TEMP/mount"
MOUNTED=0

cleanup() {
  if [[ "$MOUNTED" == "1" ]]; then
    /usr/bin/hdiutil detach "$MOUNT" -quiet >/dev/null 2>&1 || true
  fi
  /bin/rm -rf "$TEMP" >/dev/null 2>&1 || true
}
trap cleanup EXIT INT TERM

[[ "$(uname -s)" == "Darwin" ]] || { echo "FAIL=REQUIRES_MACOS"; exit 1; }
command -v gh >/dev/null || { echo "FAIL=GH_REQUIRED"; exit 1; }
command -v python3 >/dev/null || { echo "FAIL=PYTHON3_REQUIRED"; exit 1; }
gh auth status -h github.com >/dev/null 2>&1 || { echo "FAIL=GH_AUTH_REQUIRED"; exit 1; }
[[ "$(gh api "repos/$REPO" --jq .full_name)" == "$REPO" ]] || { echo "FAIL=WRONG_GITHUB_REPOSITORY"; exit 1; }
if gh release view "$TAG" -R "$REPO" >/dev/null 2>&1; then
  echo "FAIL=RELEASE_ALREADY_EXISTS"
  gh release view "$TAG" -R "$REPO" --json url,isDraft,isPrerelease
  exit 1
fi

file_size() { /usr/bin/stat -f '%z' "$1" 2>/dev/null || echo MISSING; }
file_sha() { /usr/bin/shasum -a 256 "$1" 2>/dev/null | /usr/bin/awk '{print $1}'; }
FOUND=""

consider() {
  local candidate="$1"
  [[ -f "$candidate" ]] || return 0
  if [[ "$(file_size "$candidate")" == "$BYTES" && "$(file_sha "$candidate")" == "$SHA" ]]; then
    FOUND="$candidate"
  else
    echo "SKIPPED_DIFFERENT_BUILD=$candidate"
  fi
}
locate() {
  [[ -n "$FOUND" ]] && return 0
  [[ -n "${CHATGPT_DROP_RELEASE_DMG:-}" ]] && consider "$CHATGPT_DROP_RELEASE_DMG"
  [[ -n "$FOUND" ]] && return 0
  consider "$HOME/Desktop/ChatGPT Drop Release/$NAME"
  [[ -n "$FOUND" ]] && return 0
  consider "$HOME/Downloads/$NAME"
  [[ -n "$FOUND" ]] && return 0
  consider "$ARCHIVE/$NAME"
  [[ -n "$FOUND" ]] && return 0
  local dir
  for dir in /Volumes/*; do
    [[ -d "$dir" ]] || continue
    consider "$dir/$REL/$NAME"
    [[ -n "$FOUND" ]] && return 0
  done
}

locate
if [[ -z "$FOUND" && -n "${CHATGPT_DROP_NAS_URL:-}" ]]; then
  /usr/bin/open "$CHATGPT_DROP_NAS_URL"
  echo "If Finder prompts for SMB credentials, authorize the mount there."
  for ((i=1; i<=75; i++)); do
    locate
    [[ -n "$FOUND" ]] && break
    /bin/sleep 2
  done
fi
[[ -n "$FOUND" ]] || {
  echo "FAIL=EXACT_RC14_DMG_NOT_FOUND"
  echo "Mount the NAS SMB share in Finder or set CHATGPT_DROP_RELEASE_DMG to an exact local DMG path."
  exit 1
}
mkdir -p "$ARCHIVE"
/bin/cp -p "$FOUND" "$ARCHIVE/$NAME"
DMG="$ARCHIVE/$NAME"
[[ "$(file_size "$DMG")" == "$BYTES" && "$(file_sha "$DMG")" == "$SHA" ]] || {
  echo "FAIL=LOCAL_COPY_HASH"; exit 1
}
echo "LOCAL_ARCHIVE_SAVED=$DMG"

/usr/bin/hdiutil verify "$DMG" >/dev/null
/usr/bin/codesign --verify --verbose=2 "$DMG"
mkdir -p "$MOUNT"
/usr/bin/hdiutil attach "$DMG" -readonly -nobrowse -quiet -mountpoint "$MOUNT"
MOUNTED=1
APP="$MOUNT/ChatGPT Drop Installer.app"
[[ -d "$APP" ]] || { echo "FAIL=DMG_INSTALLER_MISSING"; exit 1; }
/usr/bin/codesign --verify --deep --strict "$APP"
[[ -f "$APP/Contents/Resources/runtime/chatgpt_drop.py" ]] || {
  echo "FAIL=EXPECTED_DISCLOSED_PYTHON_NOT_FOUND"
  exit 1
}
echo "DMG_BYTES_SHA_SIGNATURE=PASS"
echo "SOURCE_VISIBILITY=READABLE_PROPRIETARY_PYTHON; NO_REUSE_LICENSE"
/usr/bin/hdiutil detach "$MOUNT" -quiet
MOUNTED=0

fetch_text() {
  gh api "repos/$REPO/contents/$1?ref=main" --jq .content |
    /usr/bin/tr -d '\n' | /usr/bin/base64 -D > "$2"
  [[ -s "$2" ]] || { echo "FAIL=EMPTY_GITHUB_FILE:$1"; exit 1; }
}
fetch_text "releases/v0.9.0-rc14.md" "$TEMP/NOTES.md"
fetch_text "releases/v0.9.0-rc14.sha256" "$TEMP/SHA256SUMS.txt"
fetch_text "LICENSE.md" "$TEMP/LICENSE.md"
fetch_text "THIRD_PARTY_NOTICES.md" "$TEMP/THIRD_PARTY_NOTICES.md"
/usr/bin/grep -Fq "$SHA" "$TEMP/SHA256SUMS.txt" || { echo "FAIL=NOTES_SHA"; exit 1; }
/usr/bin/grep -Fq "Proprietary Non-Commercial Preview License" "$TEMP/LICENSE.md" || {
  echo "FAIL=PUBLIC_LICENSE_NOT_READY"; exit 1
}

echo "CREATING_PRIVATE_DRAFT_FIRST=YES"
gh release create "$TAG" "$DMG" "$TEMP/SHA256SUMS.txt" "$TEMP/LICENSE.md" \
  "$TEMP/THIRD_PARTY_NOTICES.md" -R "$REPO" \
  --title "ChatGPT Drop 0.9.0-rc14 V8 — Intel macOS prerelease" \
  --notes-file "$TEMP/NOTES.md" --target main --draft --prerelease --latest=false

UPLOADED_SIZE="$(gh api "repos/$REPO/releases/tags/$TAG" \
  --jq ".assets[] | select(.name==\"$NAME\") | .size")"
[[ "$UPLOADED_SIZE" == "$BYTES" ]] || { echo "FAIL=UPLOADED_BYTES_MISMATCH"; exit 1; }
mkdir -p "$TEMP/verified"
gh release download "$TAG" -R "$REPO" --pattern "$NAME" --dir "$TEMP/verified"
[[ "$(file_sha "$TEMP/verified/$NAME")" == "$SHA" ]] || {
  echo "FAIL=RELEASE_REDOWNLOAD_HASH"; exit 1
}
echo "GITHUB_DRAFT_ASSET_HASH=PASS"
gh release edit "$TAG" -R "$REPO" --draft=false --prerelease --latest=false
LINK="$(gh release view "$TAG" -R "$REPO" --json url --jq .url)"
echo "PUBLIC_RELEASE=PASS"
echo "PUBLIC_RELEASE_URL=$LINK"

# Update public manifest only after successful publication; no other repository is touched.
fetch_text "release-manifest.json" "$TEMP/manifest.json"
python3 - "$TEMP/manifest.json" <<'PY'
import json, sys
path = sys.argv[1]
with open(path, encoding="utf-8") as f: manifest=json.load(f)
p=manifest.setdefault("publication", {})
p["release_published"]=True
p["public_asset_available"]=True
p["status"]="PUBLISHED_GITHUB_RC14_V8_PRERELEASE"
p["release_url"]="https://github.com/StefanAlMare/ChatGPT-TrueNAS/releases/tag/v0.9.0-rc14"
p["verification"]="Exact DMG re-downloaded from GitHub and SHA256 matched"
with open(path,"w",encoding="utf-8") as f:
    json.dump(manifest,f,ensure_ascii=False,indent=2)
    f.write("\n")
PY
OLD_SHA="$(gh api "repos/$REPO/contents/release-manifest.json?ref=main" --jq .sha)"
ENCODED="$(/usr/bin/base64 < "$TEMP/manifest.json" | /usr/bin/tr -d '\n')"
gh api -X PUT "repos/$REPO/contents/release-manifest.json" \
  -f message="release: mark verified RC14 V8 prerelease asset as published" \
  -f branch=main -f sha="$OLD_SHA" -f content="$ENCODED" >/dev/null
echo "MANIFEST_UPDATED=PASS"
echo "COMPLETE=PASS"
