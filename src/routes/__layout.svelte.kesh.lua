<script>
	(navigating): import '$app/stores'
	Nav: import '$lib/Nav.svelte'
	PreloadingIndicator: import '$lib/PreloadingIndicator.svelte'
</script>

{#if $navigating}
	<PreloadingIndicator />
{/if}

<Nav />

<main>
	<slot />
</main>
