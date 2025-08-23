# Calendar

A flexible calendar component for date selection. Supports single dates, multiple dates, and date ranges. Perfect for scheduling and booking systems.

```html
<flux:calendar />
```

### Basic Usage

Set the initial selected date using the `value` prop with a `Y-m-d` formatted date string:

```html
<flux:calendar value="2025-03-21" />
```

You can also bind the selection to a Livewire property using `wire:model`:

```html
<flux:calendar wire:model="date" />
```

Now you can access the selected date from your Livewire component using either a `Carbon` instance or a `Y-m-d` formatted string:

```php
<?php

use Illuminate\Support\Carbon;

class BookAppointment extends \Livewire\Component {
    public Carbon $date;

    public function mount() {
        $this->date = now();
    }
}
```

## Multiple dates

Select multiple non-consecutive dates.

```html
<flux:calendar multiple />
```

Set multiple selected dates using a comma-separated list in the `value` prop:

```html
<flux:calendar
    multiple
    value="2025-03-02,2025-03-05,2025-03-15"
/>
```

You can also bind the selection to a Livewire property using `wire:model`:

```html
<flux:calendar multiple wire:model="dates" />
```

You can access the selected dates in your Livewire component using an array of `Y-m-d` formatted date strings:

```php
<?php

use Illuminate\Support\Carbon;

class RequestTimeOff extends \Livewire\Component {
    public array $dates = [];

    public function mount() {
        $this->dates = [
            now()->format('Y-m-d'),
            now()->addDays(1)->format('Y-m-d'),
        ];
    }
}
```

## Date range

Select a range of dates.

```html
<flux:calendar mode="range" />
```

Set the initial range using the `value` prop with a start and end date separated by a forward slash:

```html
<flux:calendar mode="range" value="2025-03-02/2025-03-06" />
```

You can also bind the selection to a Livewire property using `wire:model`:

```html
<flux:calendar mode="range" wire:model="range" />
```

Now you can access the selected range from your Livewire component using an associative array of `Y-m-d` formatted date strings:

```php
<?php

class BookFlight extends \Livewire\Component {
    public ?array $range;

    public function book() {
        // ...

        $flight->depart_on = $this->range['start'];
        $flight->return_on = $this->range['end'];

        // ...
    }
}
```

Alternatively, you can use the specialized `DateRange` object for enhanced functionality:

```php
<?php

use Flux\DateRange;

class BookFlight extends \Livewire\Component {
    public ?DateRange $range;

    public function book() {
        // ...

        $flight->depart_on = $this->range->start();
        $flight->return_on = $this->range->end();

        // ...
    }
}
```

We highly recommend using the `DateRange` object for range selection, it provides a lot of useful functionality.

[Check out everything you can do with the `DateRange` object ->](#the-daterange-object)

### Range Configuration

Control range behavior with these props:

```html
<!-- Set minimum and maximum range limits -->
<flux:calendar mode="range" min-range="3" max-range="10" />

<!-- Control number of months shown -->
<flux:calendar mode="range" months="2" />
```

## Size

Adjust the calendar's size to fit your layout. Available sizes include `xs`, `sm`, `lg`, `xl`, and `2xl`.

```html
<flux:calendar size="xl" />
```

## Static

Create a non-interactive calendar for display purposes.

```html
<flux:calendar
    static
    value="2025-03-21"
    size="xs"
    :navigation="false"
/>
```

## Min/max dates

Restrict the selectable date range by setting minimum and maximum boundaries.

```html
<flux:calendar max="2025-03-21" />
```

You can also use the convenient "today" shorthand:

```html
<!-- Prevent selection before today... -->
<flux:calendar min="today" />

<!-- Prevent selection after today... -->
<flux:calendar max="today" />
```

## Unavailable dates

Disable specific dates from being selected. Useful for blocking out holidays, showing booked dates, or indicating unavailable time slots.
