# Chart

Flux's Chart component is a lightweight, zero-dependency tool for building charts in your Livewire applications. It is designed to be simple but extremely flexible, so that you can assemble and style your charts exactly as you need them.

```html
<flux:chart wire:model="data" class="aspect-3/1">
    <flux:chart.svg>
        <flux:chart.line field="visitors" class="text-pink-500 dark:text-pink-400" />

        <flux:chart.axis axis="x" field="date">
            <flux:chart.axis.line />
            <flux:chart.axis.tick />
        </flux:chart.axis>

        <flux:chart.axis axis="y">
            <flux:chart.axis.grid />
            <flux:chart.axis.tick />
        </flux:chart.axis>

        <flux:chart.cursor />
    </flux:chart.svg>

    <flux:chart.tooltip>
        <flux:chart.tooltip.heading field="date" :format="['year' => 'numeric', 'month' => 'numeric', 'day' => 'numeric']" />
        <flux:chart.tooltip.value field="visitors" label="Visitors" />
    </flux:chart.tooltip>
</flux:chart>
```

## Data structure

Flux charts expect a structured array of data, typically provided via `wire:model` or passed as a `:value` prop. Each data point should be an associative array with named fields:

```php
<?php

class Dashboard extends \Livewire\Component
{
    public array $data = [
        ['date' => '2025-03-21', 'visitors' => 267],
        ['date' => '2025-03-20', 'visitors' => 259],
        ['date' => '2025-03-19', 'visitors' => 269],
        // ...
    ];
}
```

If you've stored this data as a public property, you can use `wire:model` to bind the data to the chart:

```html
<flux:chart wire:model="data" />
```

Otherwise, you can pass data in any form directly into the `:value` prop:

```html
<flux:chart :value="$this->data" />
```

For things like simple line charts with no axes, you can pass a single array of values as well:

```html
<flux:chart :value="[1, 2, 3, 4, 5]" />
```

## Examples

### Line chart

To create a line chart, you can include the `<flux:chart.line>` component in the `<flux:chart.svg>` component:

```html
<flux:chart wire:model="data" class="aspect-[3/1]">
    <flux:chart.svg>
        <flux:chart.line field="memory" class="text-pink-500" />
        <flux:chart.point field="memory" class="text-pink-400" />

        <flux:chart.axis axis="x" field="date">
            <flux:chart.axis.tick />
            <flux:chart.axis.line />
        </flux:chart.axis>

        <flux:chart.axis axis="y" tick-values="[0, 128, 256, 384, 512]" :format="['style' => 'unit', 'unit' => 'megabyte']">
            <flux:chart.axis.grid />
            <flux:chart.axis.tick />
        </flux:chart.axis>
    </flux:chart.svg>
</flux:chart>
```

As you can see above, you can also render circular points on top of the line using the `<flux:chart.point>` component.

### Area chart

Similar to a line chart but with a filled area beneath the line. Great for showing cumulative values or emphasizing volume.

```html
<flux:chart wire:model="data" class="aspect-3/1">
    <flux:chart.svg>
        <flux:chart.line field="stock" class="text-blue-500 dark:text-blue-400" curve="none" />
        <flux:chart.area field="stock" class="text-blue-200/50 dark:text-blue-400/30" curve="none" />

        <flux:chart.axis axis="y" position="right" tick-prefix="$" :format="[
            'notation' => 'compact',
            'compactDisplay' => 'short',
            'maximumFractionDigits' => 1,
        ]">
            <flux:chart.axis.grid />
            <flux:chart.axis.tick />
        </flux:chart.axis>

        <flux:chart.axis axis="x" field="date">
            <flux:chart.axis.tick />
            <flux:chart.axis.line />
        </flux:chart.axis>
    </flux:chart.svg>
</flux:chart>
```

### Multiple lines

You can plot multiple lines in the same chart by including multiple `<flux:chart.line>` components. This helps compare different data series against each other.

```html
<flux:chart wire:model="data">
    <flux:chart.viewport class="min-h-[20rem]" >
        <flux:chart.svg>
            <flux:chart.line field="twitter" class="text-blue-500" curve="none" />
            <flux:chart.point field="twitter" class="text-blue-500" r="6" stroke-width="3" />
            <flux:chart.line field="facebook" class="text-red-500" curve="none" />
            <flux:chart.point field="facebook" class="text-red-500" r="6" stroke-width="3" />
            <flux:chart.line field="instagram" class="text-green-500" curve="none" />
            <flux:chart.point field="instagram" class="text-green-500" r="6" stroke-width="3" />

            <flux:chart.axis axis="x" field="date">
                <flux:chart.axis.tick />
                <flux:chart.axis.line />
            </flux:chart.axis>

            <flux:chart.axis axis="y" tick-start="0" tick-end="1" :format="[
                'style' => 'percent',
                'minimumFractionDigits' => 0,
                'maximumFractionDigits' => 0,
            ]">
                <flux:chart.axis.grid />
                <flux:chart.axis.tick />
            </flux:chart.axis>
        </flux:chart.svg>
    </flux:chart.viewport>

    <div class="flex justify-center gap-4 pt-4">
        <flux:chart.legend label="Instagram">
            <flux:chart.legend.indicator class="bg-green-400" />
        </flux:chart.legend>

        <flux:chart.legend label="Twitter">
            <flux:chart.legend.indicator class="bg-blue-400" />
        </flux:chart.legend>

        <flux:chart.legend label="Facebook">
            <flux:chart.legend.indicator class="bg-red-400" />
        </flux:chart.legend>
    </div>
</flux:chart>
```

You might have noticed that the above example includes a `<flux:chart.viewport>` component. This is used to constrain the chart SVG within the chart component so that you can render siblings like legends or summaries above or below it.

### Live summary

Flux charts support live summaries, which are updated as the user hovers over the chart. To enable this feature, you can include the `<flux:chart.summary>` component in the `<flux:chart>` component:

```html
<flux:card>
    <flux:chart class="grid gap-6" wire:model="data">
        <flux:chart.summary class="flex gap-12">
            <div>
                <flux:subheading>Today</flux:subheading>

                <flux:heading size="xl">
                    <flux:chart.summary.value field="sales" :format="['style' => 'currency', 'currency' => 'USD']" />
                </flux:heading>

                <flux:subheading>
                    <flux:chart.summary.value field="date" :format="['hour' => 'numeric', 'minute' => 'numeric', 'hour12' => true]" />
                </flux:subheading>
            </div>

            <div>
                <flux:subheading>Yesterday</flux:subheading>

                <flux:heading size="lg">
                    <flux:chart.summary.value field="yesterday" :format="['style' => 'currency', 'currency' => 'USD']" />
                </flux:heading>
            </div>
        </flux:chart.summary>

        <flux:chart.viewport class="aspect-[3/1]">
            <flux:chart.svg>
                <flux:chart.line field="yesterday" class="text-zinc-300 dark:text-white/40" stroke-dasharray="4 4" curve="none" />
                <flux:chart.line field="sales" class="text-sky-500 dark:text-sky-400" curve="none" />

                <flux:chart.axis axis="x" field="date">
                    <flux:chart.axis.grid />
                    <flux:chart.axis.tick />
                    <flux:chart.axis.line />
                </flux:chart.axis>

                <flux:chart.axis axis="y">
                    <flux:chart.axis.tick />
                </flux:chart.axis>

                <flux:chart.cursor />
            </flux:chart.svg>
        </flux:chart.viewport>
    </flux:chart>
</flux:card>
```

### Sparkline

A compact, single-line chart used in tables or dashboards for quick visual insights. Ideal for stock prices, memory usage, or other small-scale trends.

```html
<flux:chart :value="[15, 18, 16, 19, 22, 25, 28, 25, 29, 28, 32, 35]" class="w-[5rem] aspect-[3/1]">
    <flux:chart.svg gutter="0">
        <flux:chart.line class="text-green-500 dark:text-green-400" />
    </flux:chart.svg>
</flux:chart>
```

You might have noticed the `gutter` attribute on the `<flux:chart.svg>` component. This is because by default, the chart will be rendered with a padding of `8px` on all sides. This is to prevent overflowing contents of the chart (like tick labels or stroke lines) from being cut off at the edges of the container.

For simple charts like a sparkline, you don't want that extra padding, so you can set the `gutter` to `0` to remove it.

[Read more about the `gutter` prop ->](#chart-padding)

### Dashboard stat

A small card displaying a key metric with an embedded chart in the background. Useful for KPIs like revenue, active users, or system health.

```html
<flux:card class="overflow-hidden min-w-[12rem]">
    <flux:subheading>Revenue</flux:subheading>

    <flux:heading size="xl">$12,345</flux:heading>

    <flux:chart class="-mx-8 -mb-8 h-[3rem]" :value="[10, 12, 11, 13, 15, 14, 16, 18, 17, 19, 21, 20]">
        <flux:chart.svg gutter="0">
            <flux:chart.line class="text-sky-200 dark:text-sky-400" />
            <flux:chart.area class="text-sky-100 dark:text-sky-400/30" />
        </flux:chart.svg>
    </flux:chart>
</flux:card>
```

## Chart padding

By default, the chart will be rendered with a padding of `8px` on all sides. This is to prevent overflowing contents of the chart (like tick labels or stroke lines) from being cut off at the edges of the container.

You can control this by setting the `gutter` attribute on the `<flux:chart.svg>` component:

```html
<flux:chart>
    <flux:chart.svg gutter="12 0 12 8">
        <!-- ... -->
    </flux:chart.svg>
</flux:chart>
```

The `gutter` attribute accepts between one and four values, which correspond to the top, right, bottom, and left padding respectively. Similar to the padding property shorthand in CSS.

The example above will result in the following padding:

- **Top:** 12px
- **Right:** 0px
- **Bottom:** 12px
- **Left:** 8px

## Axis scale

You can configure the scale of an axis and its ticks by setting the `scale` attribute on the `<flux:chart.axis>` component:

```html
<flux:chart.axis axis="y" scale="linear">
    <!-- ... -->
</flux:chart.axis>
```

There are three available types of scales:

- `categorical`: For categorical data like names or categories.
- `linear`: For numeric data like stock prices or temperatures.
- `time`: For date and time data

The "y" axis is linear by default, but you can change it to a time axis by setting the `scale` attribute to `time`.

The "x" axis will automatically use a time scale if the data is date or time values. Otherwise, it will use a categorical scale.

## Axis lines

By default, axes do not include a visible baseline. You can add an axis line using `<flux:chart.axis.line>` inside the corresponding axis:

```html
<flux:chart.svg>
    <!-- ... -->

    <flux:chart.axis axis="x">
        <!-- Horizontal "X" axis line: -->
        <flux:chart.axis.line />
    </flux:chart.axis>

    <flux:chart.axis axis="y">
        <!-- Vertical "Y" axis line: -->
        <flux:chart.axis.line />
    </flux:chart.axis>
</flux:chart.svg>
```
