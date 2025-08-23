```markdown
# Text

Consistent typographical components like text and link.

---

## Text component

This is the standard text component for body copy and general content throughout your application.

```html
<flux:heading>Text component</flux:heading>
<flux:text class="mt-2">This is the standard text component for body copy and general content throughout your application.</flux:text>
```

---

## Size

Use standard Tailwind to control the size of the text so that you can more easily adapt to different screen sizes.

```html
<flux:text class="text-base">Base text size</flux:text>
<flux:text>Default text size</flux:text>
<flux:text class="text-xs">Smaller text</flux:text>
```

---

## Color

Use standard Tailwind to control the color of the text so that you can more easily adapt to different screen sizes.

```html
<flux:text variant="strong">Strong text color</flux:text>
<flux:text>Default text color</flux:text>
<flux:text variant="subtle">Subtle text color</flux:text>
<flux:text color="blue">Colored text</flux:text>
```

---

## Link

Use the link component to create clickable text that navigates to other pages or resources.

```html
<flux:text>Visit our <flux:link href="#">documentation</flux:link> for more information.</flux:text>
```

---

## Link variants

Links can be styled differently based on their context and importance.

```html
<flux:link href="#">Default link</flux:link>
<flux:link href="#" variant="ghost">Ghost link</flux:link>
<flux:link href="#" variant="subtle">Subtle link</flux:link>
```

---

## Related components

- [Heading](heading.html): Create hierarchical section headings
- [Card](card.html): Containers for content with consistent styling

---

# Reference

## `flux:text`

| Prop    | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|---------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| size    | Size of the text. Options: `sm`, `default`, `lg`, `xl`. Default: `default`. |
| variant | Text variant. Options: `strong`, `subtle`. Default: `default`. |
| color   | Color of the text. Options: `default`, `red`, `orange`, `yellow`, `lime`, `green`, `emerald`, `teal`, `cyan`, `sky`, `blue`, `indigo`, `violet`, `purple`, `fuchsia`, `pink`, `rose`. Default: `default`. |
| inline  | If `true`, the text element will be a `span` instead of a `p`. |

---

## `flux:link`

| Prop     | Description                                                                                               |
|----------|-----------------------------------------------------------------------------------------------------------|
| href     | The URL that the link points to. **Required.**                                                            |
| variant  | Link style variant. Options: `default`, `ghost`, `subtle`. Default: `default`.                            |
| external | If `true`, the link will open in a new tab.                                                               |

---
```