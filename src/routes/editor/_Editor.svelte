<script>
	(goto): import '$app/navigation'
	(default as ListErrors): import '$lib/ListErrors.svelte'
	(ajax): import '$lib/actions.js'
	
	let article
	let slug
	
	let publishing: false
	let errors
	
	add-tag: (input) *->
		set article.tagList: [article.tagList..., input.value]
		set input.value: ''
	
	remove: (index) *->
		set article.tagList: [
			article.tagList.slice(0, index)...
			article.tagList.slice(index + 1)...
		]
	
	on-submit: () *->
		set publishing: true
	
	on-response: async (res) *->
		if res.ok { goto res.headers.get 'location' }
		
	enter: (node, callback) ->
		on-keydown: (event) *->
			if event.which = 13 { callback node }
		
		node.addEventListener('keydown', on-keydown)
		
		[ destroy: () => node.removeEventListener('keydown', on-keydown) ]
	
	(article, slug)
</script>

<div class="editor-page">
	<div class="container page">
		<div class="row">
			<div class="col-md-10 offset-md-1 col-xs-12">
				<ListErrors { errors } />

				<form
					action={ "/article/{ slug }.json?_method=put" if slug else '/article.json' }
					method="post"
					use:ajax={ [:on-submit, :on-response] }
				>
					<fieldset>
						<fieldset class="form-group">
							<input
								class="form-control form-control-lg"
								type="text"
								placeholder="Article Title"
								bind:value={ article.title }
							/>
						</fieldset>

						<fieldset class="form-group">
							<input
								class="form-control"
								type="text"
								placeholder="What's this article about?"
								bind:value={ article.description }
							/>
						</fieldset>

						<fieldset class="form-group">
							<textarea
								class="form-control"
								rows="8"
								placeholder="Write your article (in markdown)"
								bind:value={ article.body }
							/>
						</fieldset>

						<fieldset class="form-group">
							<input
								class="form-control"
								type="text"
								placeholder="Enter tags"
								use:enter={ add-tag }
							/>

							<div class="tag-list">
								{#each article.tagList as tag, i}
									<span class="tag-default tag-pill">
										<i class="ion-close-round" on:click={ () -> remove i } />
										{ tag }
									</span>
								{/each}
							</div>
						</fieldset>

						<button class="btn btn-lg pull-xs-right btn-primary" disabled={ publishing }>
							Publish Article
						</button>
					</fieldset>
				</form>
			</div>
		</div>
	</div>
</div>
