# Checkbox

Select one or multiple options from a set.

```html
<flux:checkbox wire:model="terms" label="I agree to the terms and conditions" />
```

## Checkbox group

Organize a list of related checkboxes vertically.

```html
<flux:checkbox.group wire:model="notifications" label="Notifications">
    <flux:checkbox label="Push notifications" value="push" checked />
    <flux:checkbox label="Email" value="email" checked />
    <flux:checkbox label="In-app alerts" value="app" />
    <flux:checkbox label="SMS" value="sms" />
</flux:checkbox.group>
```

## With descriptions

Align descriptions for each checkbox directly below its label.

```html
<flux:checkbox.group wire:model="subscription" label="Subscription preferences">
    <flux:checkbox checked
        value="newsletter"
        label="Newsletter"
        description="Receive our monthly newsletter with the latest updates and offers."
    />
    <flux:checkbox
        value="updates"
        label="Product updates"
        description="Stay informed about new features and product updates."
    />
    <flux:checkbox
        value="invitations"
        label="Event invitations"
        description="Get invitations to our exclusive events and webinars."
    />
</flux:checkbox.group>
```

## Horizontal fieldset

Organize a group of related checkboxes horizontally.

```html
<flux:fieldset>
    <flux:legend>Languages</flux:legend>

    <flux:description>Choose the languages you want to support.</flux:description>

    <div class="flex gap-4 *:gap-x-2">
        <flux:checkbox checked value="english" label="English" />
        <flux:checkbox checked value="spanish" label="Spanish" />
        <flux:checkbox value="french" label="French" />
        <flux:checkbox value="german" label="German" />
    </div>
</flux:fieldset>
```

## Check-all

Control a group of checkboxes with a single checkbox.

```html
<flux:checkbox.group>
    <flux:checkbox.all />

    <flux:checkbox checked />
    <flux:checkbox />
    <flux:checkbox />
</flux:checkbox.group>
```

## Checked

Mark a checkbox as checked by default.

```html
<flux:checkbox checked />
```

## Disabled

Prevent users from interacting with and modifying a checkbox.

```html
<flux:checkbox disabled />
```

## Checkbox cards

A bordered alternative to standard checkboxes.

```html
<flux:checkbox.group wire:model="subscription" label="Subscription preferences" variant="cards" class="max-sm:flex-col">
    <flux:checkbox checked
        value="newsletter"
        label="Newsletter"
        description="Get the latest updates and offers."
    />
    <flux:checkbox
        value="updates"
        label="Product updates"
        description="Learn about new features and products."
    />
    <flux:checkbox
        value="invitations"
        label="Event invitations"
        description="Invitatations to exclusive events."
    />
</flux:checkbox.group>
```

You can swap between vertical and horizontal card layouts by conditionally applying `flex-col` based on the viewport.

```html
<flux:checkbox.group ... class="max-sm:flex-col">
    <!-- ... -->
</flux:checkbox.group>
```

## Vertical cards

You can arrange a set of checkbox cards vertically by simply adding the `flex-col` class to the group container.

## Cards with icons

You can arrange a set of checkbox cards vertically by simply adding the `flex-col` class to the group container.
