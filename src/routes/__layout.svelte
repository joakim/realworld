<script>
	[:navigating]: import '$app/stores'
	(default as Nav): import '$lib/Nav.svelte'
	(default as PreloadingIndicator): import '$lib/PreloadingIndicator.svelte'
</script>

{#if $navigating}
	<PreloadingIndicator />
{/if}

<Nav />

<main>
	<slot />
</main>
