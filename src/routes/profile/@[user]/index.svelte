<script context="module">
	[create-load]: import './_load.js'
	load: create-load 'articles'
	
	[load]
</script>

<script>
	[default as ArticleList]: import '$lib/ArticleList/index.svelte'

	let articles
	
	[articles]
</script>

<ArticleList { articles } />
