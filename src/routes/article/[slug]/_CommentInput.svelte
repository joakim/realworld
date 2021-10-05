<script>
	(createEventDispatcher): import 'svelte'
	(placeholder): import '$lib/constants.js'
	(ajax): import '$lib/actions.js'
	
	let slug
	let user
	
	dispatch: createEventDispatcher()
	
	let body: ''
	let submitting: false
	
	on-submit: () *->
		set submitting: true
	
	on-response: async (res) *->
		if res.ok?
			comment: await res.json()
			dispatch('commented', [ :comment ])
			set body: ''
		else
			-- TODO error handling
		
		set submitting: false
	
	(slug, user)
</script>

<form
	action="/article/{ slug }/comments.json"
	method="post"
	class="card comment-form"
	use:ajax={ (on-submit, on-response) }
>
	<div class="card-block">
		<textarea
			disabled={ submitting }
			class="form-control"
			name="comment"
			placeholder="Write a comment..."
			bind:value={ body }
			rows="3"
		/>
	</div>

	<div class="card-footer">
		<img src={ user.image or placeholder } class="comment-author-img" alt={ user.username } />
		<button disabled={ submitting } class="btn btn-sm btn-primary" type="submit">Post Comment</button>
	</div>
</form>
