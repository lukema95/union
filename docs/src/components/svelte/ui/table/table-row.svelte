<script lang="ts">
import { cn } from "#/lib/shadcn.js"
import type { WithElementRef } from "bits-ui"
import type { HTMLAttributes } from "svelte/elements"

let {
  ref = $bindable(null),
  class: className,
  children,
  ...restProps
}: WithElementRef<HTMLAttributes<HTMLTableRowElement>> = $props()
</script>

<tr
  bind:this={ref}
  class={cn(
    "hover:bg-muted/10 data-[state=selected]:bg-muted border-b transition-colors",
    className,
  )}
  {...restProps}
>
  {@render children?.()}
</tr>
