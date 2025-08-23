# Card

A container for related content, such as a form, alert, or data list.

```html
<flux:card class="space-y-6">
    <div>
        <flux:heading size="lg">Log in to your account</flux:heading>
        <flux:subheading>Welcome back!</flux:subheading>
    </div>

    <div class="space-y-6">
        <flux:input label="Email" type="email" placeholder="Your email address" />

        <flux:field>
            <div class="mb-3 flex justify-between">
                <flux:label>Password</flux:label>

                <flux:link href="#" variant="subtle" class="text-sm">Forgot password?</flux:link>
            </div>

            <flux:input type="password" placeholder="Your password" />

            <flux:error name="password" />
        </flux:field>
    </div>

    <div class="space-y-2">
        <flux:button variant="primary" class="w-full">Log in</flux:button>

        <flux:button variant="ghost" class="w-full">Sign up for a new account</flux:button>
    </div>
</flux:card>
```

## Header actions

Use the [button component](/components/button) to add actions to the header.

```html
<flux:card class="space-y-6">
    <div class="flex">
        <div class="flex-1">
            <flux:heading size="lg">Are you sure?</flux:heading>

            <flux:subheading>
                <p>Your post will be deleted permanently.</p>
                <p>This action cannot be undone.</p>
            </flux:subheading>
        </div>

        <div class="-mx-2 -mt-2">
            <flux:button variant="ghost" size="sm" icon="x-mark" inset="top right bottom" />
        </div>
    </div>

    <div class="flex gap-4">
        <flux:spacer />
        <flux:button variant="ghost">Undo</flux:button>
        <flux:button variant="danger">Delete</flux:button>
    </div>
</flux:card>
```

## Simple card

Let's be honest, a card is just a div with a border and some padding.

```html
<flux:card>
    <flux:heading size="lg">Are you sure?</flux:heading>

    <flux:subheading class="mb-4">
        <p>Your post will be deleted permanently.</p>
        <p>This action cannot be undone.</p>
    </flux:subheading>

    <flux:button variant="danger">Delete</flux:button>
</flux:card>
```

## Reference

### flux:card

| Slot    | Description                                                                                             |
| :------ | :------------------------------------------------------------------------------------------------------ |
| default | Content to display within the card. Can include headings, text, forms, buttons, and other components. |

| CSS     | Description                                                                                                                                                                                                                                                                                       |
| :------ | :------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `class` | Additional CSS classes applied to the card. Common uses: `space-y-6` for spacing between child elements, `max-w-md` for width control, `p-0` to remove padding. |

| Attribute      | Description                                                 |
| :------------- | :---------------------------------------------------------- |
| `data-flux-card` | Applied to the root element for styling and identification. |
