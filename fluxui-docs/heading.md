# Heading

A consistent heading and subheading component for your application.

```html
<flux:heading>User profile</flux:heading>
<flux:subheading>This information will be displayed publicly.</flux:subheading>
```

## Sizes

Flux offers three different heading sizes that should cover most use cases in your app.

```html
<flux:heading>Default</flux:heading>
<flux:heading size="lg">Large</flux:heading>
<flux:heading size="xl">Extra large</flux:heading>
```

## Heading level

Control the heading level: `h1`, `h2`, `h3`, that will be used for the heading element. Without a `level` prop, the heading will default to a `div`.

```html
<flux:heading level="3">User profile</flux:heading>
<flux:subheading>This information will be displayed publicly.</flux:subheading>
```

## Leading subheading

Subheadings can be placed above headings for a more interesting arrangment.

```html
<div>
    <flux:subheading>Year to date</flux:subheading>

    <flux:heading size="xl" class="mb-1">$7,532.16</flux:heading>

    <div class="flex items-center gap-2">
        <flux:icon.arrow-trending-up variant="micro" class="text-green-600 dark:text-green-500" />

        <span class="text-sm text-green-600 dark:text-green-500">15.2%</span>
    </div>
</div>
```

## Reference

### flux:heading

| Prop   | Description                                                                                             |
| :----- | :------------------------------------------------------------------------------------------------------ |
| size   | Size of the heading. Options: `base`, `lg`, `xl`. Default: `base`.                                        |
| level  | HTML heading level. Options: `1`, `2`, `3`, `4`. Default: renders as a `div` if not specified.          |
| accent | If `true`, applies accent color styling to the heading.                                                 |

### flux:subheading

| Prop | Description                                                                                             |
| :--- | :------------------------------------------------------------------------------------------------------ |
| size | Size of the subheading. Options: `sm`, `base`, `lg`, `xl`. Default: `base`.                               |
