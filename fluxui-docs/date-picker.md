# Date picker

Allow users to select dates or date ranges via a calendar overlay. Perfect for filtering data or scheduling events.

```html
<flux:date-picker />
```

## Basic usage

Set the initial selected date using the `value` prop with a `Y-m-d` formatted date string:

```html
<flux:date-picker value="2025-03-21" />
```

You can also bind the selection to a Livewire property using `wire:model`:

```html
<flux:date-picker wire:model="date" />
```

Now you can access the selected date from your Livewire component using either a `Carbon` instance or a `Y-m-d` formatted string:

```php
<?php

use Illuminate\Support\Carbon;
use App\Models\Post;

class CreatePost extends \Livewire\Component {
    public ?Carbon $date;

    public function save()
    {
        Post::create([
            // ...
            'published_at' => $this->date,
        ])

        // ...
    }
}
```

## Input trigger

Attach the date picker to a date input for more precise date selection control.

```html
<flux:date-picker wire:model="date">
    <x-slot name="trigger">
        <flux:date-picker.input />
    </x-slot>
</flux:date-picker>
```

## Range picker

Enable selection of date ranges for reporting, booking systems, or any scenario requiring a start and end date.

```html
<flux:date-picker mode="range" />
```

Set the initial range using the `value` prop with a start and end date separated by a forward slash:

```html
<flux:date-picker mode="range" value="2025-03-02/2025-03-06" />
```

You can also bind the selection to a Livewire property using `wire:model`:

```html
<flux:date-picker mode="range" wire:model="range" />
```

Now you can access the selected range from your Livewire component using an associative array of `Y-m-d` formatted date strings:

```php
<?php

use Illuminate\Support\Carbon;

class Dashboard extends \Livewire\Component {
    public array $range;

    public function mount() {
        $this->range = [
            'start' => now()->subMonth()->format('Y-m-d'),
            'end' => now()->format('Y-m-d'),
        ];
    }
}
```

Alternatively, you can use the specialized `DateRange` object for enhanced functionality:

```php
<?php

use Flux\DateRange;

class Dashboard extends \Livewire\Component {
    public DateRange $range;

    public function mount() {
        $this->range = new DateRange(now()->subMonth(), now());
    }
}
```

We highly recommend using the `DateRange` object for range selection, it provides a lot of useful functionality.

[Check out everything you can do with the `DateRange` object ->](#the-daterange-object)

## Range limits

Control the allowed range of dates that can be selected.

```html
<flux:date-picker mode="range" min-range="3" />
```

```html
<flux:date-picker mode="range" max-range="10" />
```

## Range with inputs

Use separate inputs for start and end dates to provide a clearer interface for date range selection.
