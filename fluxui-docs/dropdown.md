# Dropdown

A composable dropdown component that can handle both simple navigation menus as well as complex action menus with checkboxes, radios, and submenus.

```html
<flux:dropdown>
    <flux:button icon-trailing="chevron-down">Options</flux:button>

    <flux:menu>
        <flux:menu.item icon="plus">New post</flux:menu.item>

        <flux:menu.separator />

        <flux:menu.submenu heading="Sort by">
            <flux:menu.radio.group>
                <flux:menu.radio checked>Name</flux:menu.radio>
                <flux:menu.radio>Date</flux:menu.radio>
                <flux:menu.radio>Popularity</flux:menu.radio>
            </flux:menu.radio.group>
        </flux:menu.submenu>

        <flux:menu.submenu heading="Filter">
            <flux:menu.checkbox checked>Draft</flux:menu.checkbox>
            <flux:menu.checkbox checked>Published</flux:menu.checkbox>
            <flux:menu.checkbox>Archived</flux:menu.checkbox>
        </flux:menu.submenu>

        <flux:menu.separator />

        <flux:menu.item variant="danger" icon="trash">Delete</flux:menu.item>
    </flux:menu>
</flux:dropdown>
```

## Navigation menus

Display a simple set of links in a dropdown menu.

```html
<flux:dropdown position="bottom" align="end">
    <flux:profile avatar="/img/demo/user.png" name="Olivia Martin" />

    <flux:navmenu>
        <flux:navmenu.item href="#" icon="user">Account</flux:navmenu.item>
        <flux:navmenu.item href="#" icon="building-storefront">Profile</flux:navmenu.item>
        <flux:navmenu.item href="#" icon="credit-card">Billing</flux:navmenu.item>
        <flux:navmenu.item href="#" icon="arrow-right-start-on-rectangle">Logout</flux:navmenu.item>
        <flux:navmenu.item href="#" icon="trash" variant="danger">Delete</flux:navmenu.item>
    </flux:navmenu>
</flux:dropdown>
```

## Positioning

Customize the position of the dropdown menu via the `position` and `align` props. You can first pass the base position: `top`, `bottom`, `left`, and `right`, then an alignment modifier like `start`, `center`, or `end`.

```html
<flux:dropdown position="top" align="start">

<!-- More positions... -->
<flux:dropdown position="right" align="center">
<flux:dropdown position="bottom" align="center">
<flux:dropdown position="left" align="end">
```

## Offset & gap

Customize the offset/gap of the dropdown menu via the `offset` and `gap` props. These properties accept values in pixels.

```html
<flux:dropdown offset="-15" gap="2">
```

## Keyboard hints

Add keyboard shortcut hints to menu items to teach users how to navigate your app faster.

```html
<flux:dropdown>
    <flux:button icon-trailing="chevron-down">Options</flux:button>

    <flux:menu>
        <flux:menu.item icon="pencil-square" kbd="⌘S">Save</flux:menu.item>
        <flux:menu.item icon="document-duplicate" kbd="⌘D">Duplicate</flux:menu.item>
        <flux:menu.item icon="trash" variant="danger" kbd="⌘⌫">Delete</flux:menu.item>
    </flux:menu>
</flux:dropdown>
```

## Checkbox items

Select one or many menu options.

```html
<flux:dropdown>
    <flux:button icon-trailing="chevron-down">Permissions</flux:button>

    <flux:menu>
        <flux:menu.checkbox wire:model="read" checked>Read</flux:menu.checkbox>
        <flux:menu.checkbox wire:model="write" checked>Write</flux:menu.checkbox>
        <flux:menu.checkbox wire:model="delete">Delete</flux:menu.checkbox>
    </flux:menu>
</flux:dropdown>
```

## Radio items

Select a single menu option.

```html
<flux:dropdown>
    <flux:button icon-trailing="chevron-down">Sort by</flux:button>

    <flux:menu>
        <flux:menu.radio.group wire:model="sortBy">
            <flux:menu.radio checked>Latest activity</flux:menu.radio>
            <flux:menu.radio>Date created</flux:menu.radio>
            <flux:menu.radio>Most popular</flux:menu.radio>
        </flux:menu.radio.group>
    </flux:menu>
</flux:dropdown>
```

## Groups

Visually group related menu items with a separator line.

```html
<flux:dropdown>
    <flux:button icon-trailing="chevron-down">Options</flux:button>

    <flux:menu>
        <flux:menu.item>View</flux:menu.item>
        <flux:menu.item>Transfer</flux:menu.item>

        <flux:menu.separator />

        <flux:menu.item>Publish</flux:menu.item>
        <flux:menu.item>Share</flux:menu.item>

        <flux:menu.separator />

        <flux:menu.item variant="danger">Delete</flux:menu.item>
    </flux:menu>
</flux:dropdown>
```

## Groups with headings

Group options under headings to make them more discoverable.

```html
<flux:dropdown>
    <flux:button icon-trailing="chevron-down">Options</flux:button>

    <flux:menu>
        <flux:menu.group heading="Account">
            <flux:menu.item>Profile</flux:menu.item>
            <flux:menu.item>Permissions</flux:menu.item>
        </flux:menu.group>

        <flux:menu.group heading="Billing">
            <flux:menu.item>Transactions</flux:menu.item>
            <flux:menu.item>Payouts</flux:menu.item>
            <flux:menu.item>Refunds</flux:menu.item>
        </flux:menu.group>

        <flux:menu.item>Logout</flux:menu.item>
    </flux:menu>
</flux:dropdown>
```

## Submenus

Nest submenus for more condensed menus.

```html
<flux:dropdown>
    <flux:button icon-trailing="chevron-down">Options</flux:button>

    <flux:menu>
        <flux:menu.submenu heading="Sort by">
            <flux:menu.radio.group>
                <flux:menu.radio checked>Name</flux:menu.radio>
                <flux:menu.radio>Date</flux:menu.radio>
                <flux:menu.radio>Popularity</flux:menu.radio>
            </flux:menu.radio.group>
        </flux:menu.submenu>

        <flux:menu.submenu heading="Filter">
            <flux:menu.checkbox checked>Draft</flux:menu.checkbox>
            <flux:menu.checkbox checked>Published</flux:menu.checkbox>
            <flux:menu.checkbox>Archived</flux:menu.checkbox>
        </flux:menu.submenu>
    </flux:menu>
</flux:dropdown>
```
