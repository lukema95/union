<script lang="ts">
import { goto } from "$app/navigation"
import Buttons from "$lib/components/Terminal/Install/Buttons.svelte"
import { Contributions } from "$lib/state/contributions.svelte.ts"
import { getState } from "$lib/state/index.svelte.ts"
import { onDestroy, onMount } from "svelte"

const { terminal } = getState()

let contributions: Contributions | null = null
let data: Array<{ text: string; action: string }> = $state([])

onMount(() => {
  contributions = new Contributions()
})

onDestroy(() => {
  if (contributions) {
    contributions = null
  }
})

$effect(() => {
  if (contributions) {
    data = contributions.data.map(contribution => ({
      text: contribution.payload_id,
      action: contribution.public_key_hash,
    }))
  }
})

function trigger(value: string) {
  goto(`/contributions/${value}`)
  terminal.setTab(4)
  terminal.setHash(value)
}
</script>
<Buttons
  {data}
  trigger={(value) => trigger(value)}
/>
