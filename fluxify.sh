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
mapfile -t files < <(cd "$SRC_DIR" && find . -type f ! -path "./.git/*" ! -name "$(basename "$0")" | sed 's|^\./||')

# Copy each file
for rel in "${files[@]}"; do
  src="$SRC_DIR/$rel"
  dest="$DEST_DIR/$rel"
  mkdir -p "$(dirname "$dest")"
  # if the src contains 'fluxui' then copy without asking
  if [[ "$src" == *"fluxui"* ]]; then
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

echo "## Remember to add the following to your routes/web.php:

Route::middleware('guest')->group(function () {
    Route::redirect('/', '/login');

    Route::get('/login', [\App\Http\Controllers\Auth\SSOController::class, 'login'])->name('login');
    // Or as a Livewire component if you prefer
    // Route::get('/login', App\Livewire\Login::class)->name('login');
});

// SSO specific routes
Route::post('/login', [\App\Http\Controllers\Auth\SSOController::class, 'localLogin'])->name('login.local');
Route::get('/login/sso', [\App\Http\Controllers\Auth\SSOController::class, 'ssoLogin'])->name('login.sso');
Route::get('/auth/callback', [\App\Http\Controllers\Auth\SSOController::class, 'handleProviderCallback'])->name('sso.callback');
Route::post('/logout', [\App\Http\Controllers\Auth\SSOController::class, 'logout'])->name('auth.logout');
Route::get('/logged-out', [\App\Http\Controllers\Auth\SSOController::class, 'loggedOut'])->name('logged_out');

## And this to your config/services.php:

    'keycloak' => [
      'client_id' => env('KEYCLOAK_CLIENT_ID'),
      'client_secret' => env('KEYCLOAK_CLIENT_SECRET'),
      'redirect' => env('KEYCLOAK_REDIRECT_URI'),
      'base_url' => env('KEYCLOAK_BASE_URL'),
      'realms' => env('KEYCLOAK_REALM')
    ],

## And this to your app/Providers/AppServiceProvider.php:

    public function boot(): void
    {
        // ...
        Event::listen(function (\SocialiteProviders\Manager\SocialiteWasCalled \$event) {
            \$event->extendSocialite('keycloak', \SocialiteProviders\Keycloak\Provider::class);
        });
    }

## And this to your .env:
KEYCLOAK_BASE_URL=https://
KEYCLOAK_REALM=
KEYCLOAK_CLIENT_ID=name-in-keycloak
KEYCLOAK_CLIENT_SECRET=secret-in-keycloak
KEYCLOAK_REDIRECT_URI=http://your-app/auth/callback

SSO_ENABLED=true
SSO_AUTOCREATE_NEW_USERS=false
SSO_ALLOW_STUDENTS=false
SSO_ADMINS_ONLY=false
"

echo
echo "Done"
