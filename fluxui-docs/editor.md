# Rich text editor

A basic rich text editor for your application. Built using [ProseMirror](https://prosemirror.net) and [Tiptap](https://tiptap.dev/).

```html
<flux:editor wire:model="content" label="…" description="…" />
```

## Toolbar

Flux's editor toolbar is both keyboard/screen-reader accessible and completely customizable to suit your application's needs.

### Configuring items

You can configure which toolbar items are visible, and in what order, by passing in a space-separated list of items to the `toolbar` prop.

```html
<flux:editor toolbar="heading | bold italic underline | align ~ undo redo" />
```

You may have noticed the `|` and `~` characters in the toolbar configuration. These are shorthand for `separator` and `spacer` respectively.

The following toolbar items are available:

- `heading`
- `bold`
- `italic`
- `strike`
- `underline`
- `bullet`
- `ordered`
- `blockquote`
- `subscript`
- `superscript`
- `highlight`
- `link`
- `code`
- `undo`
- `redo`

### Custom items

You can add your own toolbar items by adding new files to the `resources/views/flux/editor` directory in your project.

```
- resources
    - views
        - flux
            - editor
                - copy.blade.php
```

Here's an example of what a custom "Copy to clipboard" item in a blade file might look like:

```html
<flux:tooltip content="{{ __('Copy to clipboard') }}" class="contents">
    <flux:editor.button x-on:click="navigator.clipboard?.writeText($el.closest('[data-flux-editor]').value); $el.setAttribute('data-copied', ''); setTimeout(() => $el.removeAttribute('data-copied'), 2000)">
        <flux:icon.clipboard variant="outline" class="[[data-copied]_&]:hidden size-5!" />
        <flux:icon.clipboard-document-check variant="outline" class="hidden [[data-copied]_&]:block size-5!" />
    </flux:editor.button>
</flux:tooltip>
```

Now you can reference your new component by name in any toolbar configuration like so:

```html
<flux:editor toolbar="heading | […] | align ~ copy" />
```

### Customization

If you have deeper customization needs, you can compose your own editor component. Here's an example of putting a custom dropdown menu in an editor's toolbar:

```html
<flux:editor>
    <flux:editor.toolbar>
        <flux:editor.heading />
        <flux:editor.separator />
        <flux:editor.bold />
        <flux:editor.italic />
        <flux:editor.strike />
        <flux:editor.separator />
        <flux:editor.bullet />
        <flux:editor.ordered />
        <flux:editor.blockquote />
        <flux:editor.separator />
        <flux:editor.link />
        <flux:editor.separator />
        <flux:editor.align />

        <flux:editor.spacer />

        <flux:dropdown position="bottom end" offset="-15">
            <flux:editor.button icon="ellipsis-horizontal" tooltip="More" />

            <flux:menu>
                <flux:menu.item wire:click="…" icon="arrow-top-right-on-square">Preview</flux:menu.item>
                <flux:menu.item wire:click="…" icon="arrow-down-tray">Export</flux:menu.item>
                <flux:menu.item wire:click="…" icon="share">Share</flux:menu.item>
            </flux:menu>
        </flux:dropdown>
    </flux:editor.toolbar>

    <flux:editor.content />
</flux:editor>
```

## Height

By default, the editor will have a minimum height of 200px, and a maximum height of 500px. If you want to customize this behavior, you can use Tailwind utilties to target the content slot and set your own min/max height and overflow behavior.
