# Separator

Visually divide sections of content or groups of items.

---

## Basic Usage

```html
<flux:separator />
```

---

## With text

Add text to the separator for a more descriptive element.

```html
<flux:separator text="or" />
```

---

## Vertical

Separate contents with a vertical separator when horizontally stacked.

```html
<flux:separator vertical />
```

---

## Limited height

You can limit the height of the vertical separator by adding vertical margin.

```html
<flux:separator vertical class="my-2" />
```

---

## Subtle

Flux offers a subtle variant for a separator that blends into the background.

```html
<flux:separator vertical variant="subtle" />
```

---

# Reference

## `flux:separator`

| Prop         | Description                                                                                                                                                       |
| ------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `vertical`   | Displays a vertical separator. Default is horizontal.                                                                                                             |
| `variant`    | Visual style variant. Options: `subtle`. Default: standard separator.                                                                                             |
| `text`       | Optional text to display in the center of the separator.                                                                                                          |
| `orientation`| Alternative to `vertical` prop. Options: `horizontal`, `vertical`. Default: `horizontal`.                                                                        |

---

| Class      | Description                                  |
| ---------- | -------------------------------------------- |
| `my-*`     | Commonly used to shorten vertical separators.|

---

| Attribute            | Description                                        |
| -------------------- | --------------------------------------------------|
| `data-flux-separator`| Applied to the root element for styling and identification.|

---