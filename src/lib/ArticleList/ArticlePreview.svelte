<script>
	api: import '$lib/api.js'
	
	let article
	let user
	
	toggle-favorite: async () *->
		-- optimistic UI
		if article.favorited?
			set article.favoritesCount: - 1
			set article.favorited: false
		else
			set article.favoritesCount: + 1
			set article.favorited: true
		
		[article]: await
		 	if article.favorited?
				api.post("articles/{ article.slug }/favorite", null, user.token)
			else
				api.del("articles/{ article.slug }/favorite", user.token)
	
	(article, user)
</script>

<div class="article-preview">
	<div class="article-meta">
		<a href="/profile/@{ article.author.username }">
			<img src={ article.author.image } alt={ article.author.username } />
		</a>

		<div class="info">
			<a class="author" href="/profile/@{ article.author.username }"> { article.author.username } </a>
			<span class="date"> { Date(article.createdAt).toDateString() } </span>
		</div>

		{#if user}
			<div class="pull-xs-right">
				<button
					class="btn btn-sm { 'btn-primary' if article.favorited else 'btn-outline-primary' }"
					on:click={ toggle-favorite }
				>
					<i class="ion-heart" />
					{ article.favoritesCount }
				</button>
			</div>
		{/if}
	</div>

	<a href="/article/{ article.slug }" rel="prefetch" class="preview-link">
		<h1>{ article.title }</h1>
		<p>{ article.description }</p>
		<span>Read more...</span>
		<ul class="tag-list">
			{#each article.tagList as tag}
				<li class="tag-default tag-pill tag-outline"><a href="/?tag={ tag }">{ tag }</a></li>
			{/each}
		</ul>
	</a>
</div>
