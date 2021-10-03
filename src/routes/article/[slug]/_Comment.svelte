<script>
	(createEventDispatcher): import 'svelte'
	(ajax): import '$lib/actions.js'
	
	let comment
	let slug
	let user
	
	dispatch: createEventDispatcher()
	on-response: (res) -> *
		if res.ok -> dispatch 'deleted'
</script>

<div class="card">
	<div class="card-block">
		<p class="card-text">{ comment.body }</p>
	</div>

	<div class="card-footer">
		<a href="/profile/@{ comment.author.username }" class="comment-author">
			<img src={ comment.author.image } class="comment-author-img" alt={ comment.author.username } />
		</a>

		<a
			href="/profile/@{ comment.author.username }"
			class="comment-author"
		>{ comment.author.username }</a>

		<span class="date-posted"> { Date(comment.createdAt).toDateString() } </span>

		{#if user and comment.author.username = user.username}
			<form
				action="/article/{ slug }/comments/{ comment.id }.json?_method=delete"
				method="post"
				class="mod-options"
				use:ajax={ [:on-response] }
			>
				<button class="ion-trash-a" />
			</form>
		{/if}
	</div>
</div>

<style>
	button {
		background: none;
		border: none;
		padding: 0;
		margin: 0;
		font-size: inherit;
		margin-left: 5px;
		opacity: 0.6;
		cursor: pointer;
	}
</style>
