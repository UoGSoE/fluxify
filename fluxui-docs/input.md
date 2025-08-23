# Input

Capture user data with various forms of text input.

```html
<flux:input wire:model="username" label="Username" description="This will be publicly displayed." />
```

---

## Longhand

Flux makes it easy to wrap your inputs in a field with label/description and error messages. If you need more control over the layout of these fields, you can assemble the individual field components.

```html
<flux:field>
    <flux:label>Username</flux:label>
    <flux:description>This will be publicly displayed.</flux:description>
    <flux:input />
    <flux:error name="username" />
</flux:field>
```

---

## Class targeting

Unlike other form components, Flux's input component is composed of two underlying elements: an `input` element and a wrapper `div`. The wrapper div is there to add padding where icons should go.

This is typically fine, however, if you need to pass classes into the input component and have them directly applied to the input element, you can do so using the `class:input` attribute instead of simply `class`:

```html
<flux:input class="max-w-xs" class:input="font-mono" />
```

---

## Types

Use the browser's various input types for different situations: `text`, `email`, `password`, etc.

```html
<flux:input type="email" label="Email" />
<flux:input type="password" label="Password" />
<flux:input type="date" max="2999-12-31" label="Date" />
```

---

## File

Flux provides a special input component for file uploads. It's a simple wrapper around the native `input[type="file"]` element.

```html
<flux:input type="file" wire:model="logo" label="Logo"/>
<flux:input type="file" wire:model="attachments" label="Attachments" multiple />
```

---

## Smaller

Use the `size` prop to make the input's height more compact.

```html
<flux:input size="sm" placeholder="Filter by..." />
```

---

## Disabled

Prevent users from interacting with an input by disabling it.

```html
<flux:input disabled label="Email" />
```

---

## Readonly

Useful for locking an input during a form submission.

```html
<flux:input readonly variant="filled" />
```

---

## Invalid

Signal to users that the contents of an input are invalid.

```html
<flux:input invalid />
```

---

## Input masking

Restrict the formatting of text content for unique cases by using [Alpine's mask plugin](https://alpinejs.dev/plugins/mask).

```html
<flux:input mask="(999) 999-9999" value="7161234567" />
```

---

## Icons

Append or prepend an icon to the inside of a form input.

```html
<flux:input icon="magnifying-glass" placeholder="Search orders" />

<flux:input icon-trailing="credit-card" placeholder="4444-4444-4444-4444" />

<flux:input icon-trailing="loading" placeholder="Search transactions" />
```

---

## Icon buttons

Append a button to the inside of an input to provide associated functionality.

```html
<flux:input placeholder="Search orders">
    <x-slot name="iconTrailing">
        <flux:button size="sm" variant="subtle" icon="x-mark" class="-mr-1" />
    </x-slot>
</flux:input>

<flux:input type="password" value="password">
    <x-slot name="iconTrailing">
        <flux:button size="sm" variant="subtle" icon="eye" class="-mr-1" />
    </x-slot>
</flux:input>
```

---

## Clearable, copyable, and viewable inputs

Flux provides three special input properties to configure common input button behaviors. `clearable` for clearing contents, `copyable` for copying contents, and `viewable` for toggling password visibility.

```html
<flux:input placeholder="Search orders" clearable />
<flux:input type="password" value="password" viewable />
<flux:input icon="key" value="FLUX-1234-5678-ABCD-EFGH" readonly copyable />
```

---

## Keyboard hint

Hint to users what keyboard shortcuts they can use with this input.

```html
<flux:input kbd="⌘K" icon="magnifying-glass" placeholder="Search..."/>
```

---

## As a button

To render an input using a `button` element, pass "button" into the `as` prop.

```html
<flux:input as="button" placeholder="Search..." icon="magnifying-glass" kbd="⌘K" />
```

---

## With buttons

Attach buttons to the beginning or end of an input element.

```html
<flux:input.group>
    <flux:input placeholder="Post title" />
    <flux:button icon="plus">New post</flux:button>
</flux:input.group>

<flux:input.group>
    <flux:select class="max-w-fit">
        <flux:select.option selected>USD</flux:select.option>
        <!-- ... -->
    </flux:select>
    <flux:input placeholder="$99.99" />
</flux:input.group>
```

---

## Text prefixes and suffixes

Append text inside a form input.

```html
<flux:input.group>
    <flux:input.group.prefix>https://</flux:input.group.prefix>
    <flux:input placeholder="example.com" />
</flux:input.group>

<flux:input.group>
    <flux:input placeholder="chunky-spaceship" />
    <flux:input.group.suffix>.brand.com</flux:input.group.suffix>
</flux:input.group>
```

---

## Input group labels

If you want to use an input group in a form field with a label, you will need to wrap the input group in a `field` component.

```html
<flux:field>
    <flux:label>Website</flux:label>
    <flux:input.group>
        <flux:input.group.prefix>https://</flux:input.group.prefix>
        <flux:input wire:model="website" placeholder="example.com" />
    </flux:input.group>
    <flux:error name="website" />
</flux:field>
```

---

# Reference

## flux:input

| Prop                 | Description                                                                                                                 |
|----------------------|----------------------------------------------------------------------------------------------------------------------------|
| `wire:model`         | Binds the input to a Livewire property ([wire:model documentation](https://livewire.laravel.com/docs/wire-model)).           |
| `name`               | Name attribute for the input. Automatically set when using `wire:model`.                                                    |
| `label`              | Label text displayed above the input. When provided, wraps the input in a `flux:field` with a `flux:label`.                 |
| `description`        | Help text displayed above the input. Appears between label and input within the `flux:field` wrapper.                       |
| `description-trailing`| Help text displayed below the input. Appears below input within `flux:field` when provided.                                |
| `placeholder`        | Placeholder text displayed when the input is empty.                                                                         |
| `size`               | Size of the input. Options: `sm`, `xs`.                                                                                    |
| `variant`            | Visual style variant. Options: `filled` (default: `outline`).                                                              |
| `disabled`           | Prevents user interaction with the input.                                                                                   |
| `readonly`           | Makes the input read-only.                                                                                                 |
| `invalid`            | Applies error styling to the input.                                                                                        |
| `multiple`           | For file inputs, allows selecting multiple files.                                                                           |
| `mask`               | Input mask pattern using Alpine's mask plugin. Example: `99/99/9999`.                                                      |
| `icon`               | Name of the icon displayed at the start of the input.                                                                      |
| `icon-trailing`      | Name of the icon displayed at the end of the input.                                                                        |
| `kbd`                | Keyboard shortcut hint displayed at the end of the input.                                                                  |
| `clearable`          | If `true`, displays a clear button when the input has content.                                                             |
| `copyable`           | If `true`, displays a copy button to copy the input's content.                                                             |
| `viewable`           | For password inputs, displays a toggle to show/hide the password.                                                          |
| `as`                 | Render the input as a different element. Options: `button` (default: `input`).                                             |
| `class:input`        | CSS classes applied directly to the input element instead of the wrapper.                                                   |

### Slots

| Slot           | Description                                                  |
|----------------|-------------------------------------------------------------|
| `icon`         | Custom content displayed at the start of the input (e.g., icons).         |
| `icon-leading` | Custom content displayed at the start of the input (e.g., icons).         |
| `icon-trailing`| Custom content displayed at the end of the input (e.g., buttons).         |

#### Attribute

| Attribute      | Description                                            |
|----------------|-------------------------------------------------------|
| `data-flux-input` | Applied to the root element for styling and identification. |


---

## flux:input.group

| Slot    | Description                                                                       |
|---------|----------------------------------------------------------------------------------|
| default | The input group content, typically containing an input and prefix/suffix elements.|


---

## flux:input.group.prefix

| Slot    | Description                                            |
|---------|-------------------------------------------------------|
| default | Content displayed before the input (e.g., icons, text, buttons).|

---

## flux:input.group.suffix

| Slot    | Description                                         |
|---------|----------------------------------------------------|
| default | Content displayed after the input (e.g., icons, text, buttons).|

---

See the [field component documentation](/components/field) for more information.