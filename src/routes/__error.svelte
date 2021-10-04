<script context="module">
	load: ([ :error, :status ]) -> [ props: [ :error, :status ] ]
	(load)
</script>

<script>
	(dev): import '$app/env'
	
	let error
	let status
	
	(error, status)
</script>

<svelte:head>
	<title>{ status }</title>
</svelte:head>

<div class="col-md-9">
	<h1>{ status }</h1>

	<p>{ error.message }</p>

	{#if dev and error.stack}
		<pre>{ error.stack }</pre>
	{/if}
</div>

<style>
	h1,
	p {
		margin: 0 auto;
	}

	h1 {
		font-size: 2.8em;
		font-weight: 700;
		margin: 0 0 0.5em 0;
	}

	p {
		margin: 1em auto;
	}

	@media (min-width: 480px) {
		h1 {
			font-size: 4em;
		}
	}
</style>
