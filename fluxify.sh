#!/usr/bin/env bash
set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST_DIR="${1:-.}"
DEST_DIR="$(cd "$DEST_DIR" && pwd)"

if [[ -z "${FLUX_USERNAME:-}" || -z "${FLUX_LICENSE_KEY:-}" ]]; then
  echo "FLUX_USERNAME and/or FLUX_LICENSE_KEY not set. Export them and re-run."
  exit 1
fi

[[ -f "$DEST_DIR/artisan" ]] || { echo "${DEST_DIR} is not a Laravel project (artisan not found)."; exit 1; }

# Bail if there are uncommitted changes in the destination directory
( cd "$DEST_DIR" && git status | grep -q 'working tree clean' ) || { echo "There are uncommitted changes in the destination directory. Please commit or stash them and re-run."; exit 1; }

# Build array of files to copy
mapfile -t files < <(cd "$SRC_DIR" && find . -type f ! -path "./.git/*" ! -name "$(basename "$0")" ! -name 'README.md' | sed 's|^\./||')

# Copy each file
for rel in "${files[@]}"; do
  src="$SRC_DIR/$rel"
  dest="$DEST_DIR/$rel"
  mkdir -p "$(dirname "$dest")"
  # if the src contains 'fluxui' or 'SSOServiceProvider' then copy without asking
  if [[ "$src" == *"fluxui"* || "$src" == *"SSOServiceProvider"* ]]; then
    cp "$src" "$dest"
  else
    # if the user picks no - we skip copying but the script carries on
    cp -i "$src" "$dest" || echo "Skipping $src"
  fi
done

( cd "$DEST_DIR" && npm install -D vite tailwindcss @tailwindcss/vite )
( cd "$DEST_DIR" && composer require livewire/flux laravel/socialite socialiteproviders/keycloak)
( cd "$DEST_DIR" && php artisan flux:activate "${FLUX_USERNAME}" "${FLUX_LICENSE_KEY}" )

# if .gitignore exists, add the following to it if they are not already there
if [ -f "$DEST_DIR/.gitignore" ]; then
  grep -q "fluxui" "$DEST_DIR/.gitignore" || echo "fluxui*" >> "$DEST_DIR/.gitignore"
  grep -q "auth.json" "$DEST_DIR/.gitignore" || echo "auth.json" >> "$DEST_DIR/.gitignore"
fi

grep -q "boost" "$DEST_DIR/composer.json" || echo "Consider doing a \`composer require laravel/boost\` to add the laravel MCP for helping with flux/livewire."

echo "If you use claude code - there are some helpful commands installed in the .claude/commands directory to help you migrate an existing frontend if this is an older project."
echo "Complete"
