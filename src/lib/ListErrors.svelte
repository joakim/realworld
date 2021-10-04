<script>
	let errors
	(errors)
</script>

{#if errors}
	<ul class="error-messages">
		{#each collection.keys(errors) as key}
			<li>{ key } { errors.{ key } }</li>
		{/each}
	</ul>
{/if}
