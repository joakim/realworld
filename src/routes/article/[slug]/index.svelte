<script context="module">
	load: async ([ :page, :fetch ]) ->
		[:slug]: page.params
		[article, comments]: await Promise.all [
			fetch("/article/{ slug }.json").then (r) -> r.json()
			fetch("/article/{ slug }/comments.json").then (r) -> r.json()
		]
		
		[ props: [ :article, :comments, :slug ] ]
	
	(load)
</script>

<script>
	(session): import '$app/stores'
	(default as marked): import 'marked'
	
	(default as ArticleMeta): './_ArticleMeta.svelte'
	(default as CommentContainer): './_CommentContainer.svelte'
	
	let article
	let comments
	let slug
	
	$ markup: marked article.body
	
	(article, comments, slug)
</script>

<svelte:head>
	<title>{ article.title }</title>
</svelte:head>

<div class="article-page">
	<div class="banner">
		<div class="container">
			<h1>{ article.title }</h1>
			<ArticleMeta { article } user={ $session.user } />
		</div>
	</div>

	<div class="container page">
		<div class="row article-content">
			<div class="col-xs-12">
				<div>
					{@html markup}
				</div>

				<ul class="tag-list">
					{#each article.tagList as tag}
						<li class="tag-default tag-pill tag-outline">{ tag }</li>
					{/each}
				</ul>
			</div>
		</div>

		<hr />

		<div class="article-actions" />

		<div class="row">
			<CommentContainer { slug } { comments } user={ $session.user } errors={ [] } />
		</div>
	</div>
</div>
