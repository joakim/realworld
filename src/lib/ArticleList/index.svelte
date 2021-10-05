<script>
	(session): import '$app/stores'
	(default as ArticlePreview): import './ArticlePreview.svelte'
	
	let articles
	
	(articles)
</script>

{#if articles.length = 0}
	<div class="article-preview">No articles are here... yet.</div>
{:else}
	<div>
		{#each articles as article (article.slug)}
			<ArticlePreview { article } user={ $session.user } />
		{/each}
	</div>
{/if}
