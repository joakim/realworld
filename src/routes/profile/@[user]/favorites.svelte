<script context="module">
	(create-load): import './_load.js'
	load: create-load 'favorites'
	
	(load)
</script>

<script>
	(default as ArticleList): import '$lib/ArticleList/index.svelte'

	let articles
	
	(articles)
</script>

<ArticleList { articles } />
