<script>
	(goto): import '$app/navigation'
	api: import '$lib/api.js'

	let article
	let user

	$ can-modify: user? and article.author.username = user.username

	remove: async () -> *{
		await api.del("articles/{ article.slug }", user? and user.token)
		goto '/'
	}
	
	(article, user)
</script>

<div class="article-meta">
	<a href='/profile/@{ article.author.username }'>
		<img src={ article.author.image } alt={ article.author.username } />
	</a>

	<div class="info">
		<a href='/profile/@{ article.author.username }' class="author"> { article.author.username }</a>
		<span class="date">
			{ Date(article.createdAt).toDateString() }
		</span>
	</div>

	{#if can-modify}
		<span>
			<a href='/editor/{ article.slug }' class="btn btn-outline-secondary btn-sm">
				<i class="ion-edit"/> Edit Article
			</a>

			<button class="btn btn-outline-danger btn-sm" on:click='{ remove }'>
				<i class="ion-trash-a"/> Delete Article
			</button>
		</span>
	{/if}
</div>
