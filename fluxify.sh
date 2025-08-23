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

# Build array of files to copy
mapfile -t files < <(cd "$SRC_DIR" && find . -type f ! -path "./.git/*" ! -name "$(basename "$0")" | sed 's|^\./||')

# Copy each file
for rel in "${files[@]}"; do
  src="$SRC_DIR/$rel"
  dest="$DEST_DIR/$rel"
  mkdir -p "$(dirname "$dest")"
  cp -i "$src" "$dest"
done

( cd "$DEST_DIR" && npm install vite tailwindcss @tailwindcss/vite )
( cd "$DEST_DIR" && composer require livewire/flux )
( cd "$DEST_DIR" && php artisan flux:activate "${FLUX_USERNAME}" "${FLUX_LICENSE_KEY}" )

HAS_SSO=$(grep -q "SSOController" "$DEST_DIR/routes/web.php" && echo "true" || echo "false")

if [ "$HAS_SSO" = "false" ]; then
echo "Remember to add the following to your routes/web.php:

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
"
fi

echo
echo "Done"
