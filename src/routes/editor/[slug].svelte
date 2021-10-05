<script context="module">
	api: import '$lib/api.js'
	
	load: async [page, session] ->
		if not session.user?
			return [redirect: '/login', status: 302]
		
		[slug]: page.params
		[article]: await api.get("articles/{ slug }", null)
		
		[ props: [ :article, :slug ] ]
	
	(load)
</script>

<script>
	(default as Editor): import './_Editor.svelte'
	
	let slug
	let article
	
	(slug, article)
</script>

<Editor { article } { slug }/>
