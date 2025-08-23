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

# Make a new SSOServiceProvider (we will overwrite it - but this will properly register it with laravel)
if [ ! -f "$DEST_DIR/app/Providers/SSOServiceProvider.php" ]; then
  ( cd "$DEST_DIR" && php artisan make:provider SSOServiceProvider )
fi

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

( cd "$DEST_DIR" && npm install vite tailwindcss @tailwindcss/vite )
( cd "$DEST_DIR" && composer require livewire/flux laravel/socialite socialiteproviders/keycloak)
( cd "$DEST_DIR" && php artisan flux:activate "${FLUX_USERNAME}" "${FLUX_LICENSE_KEY}" )

# if .gitignore exists, add the following to it if they are not already there
if [ -f "$DEST_DIR/.gitignore" ]; then
  grep -q "fluxui" "$DEST_DIR/.gitignore" || echo "fluxui*" >> "$DEST_DIR/.gitignore"
  grep -q "auth.json" "$DEST_DIR/.gitignore" || echo "auth.json" >> "$DEST_DIR/.gitignore"
fi

upsert_env() {
  local key=$1 val=$2 mainfile="$DEST_DIR/.env" examplefile="$DEST_DIR/.env.example"
  if [ -f "$mainfile" ]; then
    grep -q "^${key}=" "$mainfile" || echo "${key}=${val}" >> "$mainfile"
  fi
  if [ -f "$examplefile" ]; then
    grep -q "^${key}=" "$examplefile" || echo "${key}=${val}" >> "$examplefile"
  fi
}
upsert_env "KEYCLOAK_BASE_URL" "https://"
upsert_env "KEYCLOAK_REALM" ""
upsert_env "KEYCLOAK_CLIENT_ID" "name-in-keycloak"
upsert_env "KEYCLOAK_CLIENT_SECRET" "secret-in-keycloak"
upsert_env "KEYCLOAK_REDIRECT_URI" "http://your-app/auth/callback"
upsert_env "SSO_ENABLED" "true"
upsert_env "SSO_AUTOCREATE_NEW_USERS" "false"
upsert_env "SSO_ALLOW_STUDENTS" "false"
upsert_env "SSO_ADMINS_ONLY" "false"

echo "## Remember to add the following near the top of your routes/web.php:

require __DIR__ . '/sso-auth.php';

## And this to your config/services.php:

    'keycloak' => [
      'client_id' => env('KEYCLOAK_CLIENT_ID'),
      'client_secret' => env('KEYCLOAK_CLIENT_SECRET'),
      'redirect' => env('KEYCLOAK_REDIRECT_URI'),
      'base_url' => env('KEYCLOAK_BASE_URL'),
      'realms' => env('KEYCLOAK_REALM')
    ],
"

echo
echo "Done"
