<script>
	(default as CommentInput): import './_CommentInput.svelte'
	(default as Comment): import './_Comment.svelte'
	
	let comments
	let slug
	let user
	
	(comments, slug, user)
</script>

<div class="col-xs-12 col-md-8 offset-md-2">
	{#if user}
		<div>
			<CommentInput
				{ slug }
				{ user }
				on:commented={ [detail] *-> (set comments: [detail.comment, comments...]) }
			/>
		</div>
	{:else}
		<p>
			<a href="/login">Sign in</a>
			or
			<a href="/register">sign up</a>
			to add comments on this article.
		</p>
	{/if}

	{#each comments as comment, i (comment.id)}
		<Comment
			{ comment }
			{ slug }
			{ user }
			on:deleted={ () *-> (set comments: [comments.slice(0, i)..., comments.slice(i + 1)...]) }
		/>
	{/each}
</div>
