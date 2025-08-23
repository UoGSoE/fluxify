# Fluxify

A Laravel project migration tool that automates the setup of Livewire Flux UI components.

## Prerequisites

- Existing Laravel project
- Node.js and npm
- Composer
- Valid Flux license credentials

## Setup

Set your Flux credentials as environment variables:

```bash
export FLUX_USERNAME="email-address"
export FLUX_LICENSE_KEY="the-flux-license-key"
```

## Usage

Run the script and point it to your project directory:

```bash
./fluxify.sh /path/to/your/laravel/project
```

## What It Does

1. **Validates** Flux credentials and Laravel project
2. **Copies** templates, config files to your project
3. **Installs** required npm packages: vite, tailwindcss, @tailwindcss/vite
4. **Installs** Livewire Flux
5. **Activates** your Flux license

