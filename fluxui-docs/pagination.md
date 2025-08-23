```markdown
# Pagination

Display a series of buttons to navigate through a list of items.

> **Flux Pro component**  
> This component is only available in the Pro version of Flux.

---

```blade
<!-- $orders = Order::paginate() -->
<flux:pagination :paginator="$orders" />
```

---

## Simple paginator

Use the simple paginator when working with large datasets where counting the total number of results would be expensive. The simple paginator provides "Previous" and "Next" buttons without displaying the total number of pages or records.

```blade
<!-- $orders = Order::simplePaginate() -->
<flux:pagination :paginator="$orders" />
```

---

## Large result set

When working with large result sets, the pagination component automatically adapts to show a reasonable number of page links. It shows the first and last pages, along with a window of pages around the current page, and adds ellipses for any gaps to ensure efficient navigation through numerous pages.

```blade
<!-- $orders = Order::paginate(5) -->
<flux:pagination :paginator="$orders" />
```

---

## Related components

- [Table](table.md) – Display tabular data

---

## Reference

### `<flux:pagination>`

| Prop      | Description                      |
|-----------|----------------------------------|
| paginator | The paginator instance to display. |

---
```