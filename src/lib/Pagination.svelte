<script>
	let pages
	let p
	let href
	
	let range
	$ -> set range: array.from [1..pages]
	
	(pages, p, href)
</script>

{#if pages > 1}
	<nav>
		<ul class="pagination">
			{#each range as n}
				<li class="page-item" class:active={ n = p }><a class="page-link" href={ href n }>{ n }</a></li>
			{/each}
		</ul>
	</nav>
{/if}
