<script context="module">
	load: ([ :session ]) ->
		[ :user ]: session
		
		if not user? -> return [ status: 302, redirect: '/login' ]
		
		[ props: [ :user ] ]
	
	(load)
</script>

<script>
	[ session ]: import '$app/stores'
	(default as ListErrors): import '$lib/ListErrors.svelte'
	[ post ]: import '$lib/utils.js'
	
	let user
	let in-progress
	let errors
	
	logout: async () *->
		await post('auth/logout')
		
		-- this will trigger a redirect, because it
		-- causes the `load` function to run again
		set $session.user: null

	save: async () *->
		set in-progress: true

		response: await post('auth/save', user)

		set errors: response.errors
		if response.user? -> set $session.user: response.user

		set in-progress: false
	
	(user)
</script>

<svelte:head>
	<title>Settings • Conduit</title>
</svelte:head>

<div class="settings-page">
	<div class="container page">
		<div class="row">
			<div class="col-md-6 offset-md-3 col-xs-12">
				<h1 class="text-xs-center">Your Settings</h1>

				<ListErrors { errors } />

				<form on:submit|preventDefault={ save }>
					<fieldset>
						<fieldset class="form-group">
							<input
								class="form-control"
								type="text"
								placeholder="URL of profile picture"
								bind:value={ user.image }
							/>
						</fieldset>

						<fieldset class="form-group">
							<input
								class="form-control form-control-lg"
								type="text"
								placeholder="Username"
								bind:value={ user.username }
							/>
						</fieldset>

						<fieldset class="form-group">
							<textarea
								class="form-control form-control-lg"
								rows="8"
								placeholder="Short bio about you"
								bind:value={ user.bio }
							/>
						</fieldset>

						<fieldset class="form-group">
							<input
								class="form-control form-control-lg"
								type="email"
								placeholder="Email"
								bind:value={ user.email }
							/>
						</fieldset>

						<fieldset class="form-group">
							<input
								class="form-control form-control-lg"
								type="password"
								placeholder="New Password"
								bind:value={ user.password }
							/>
						</fieldset>

						<button
							class="btn btn-lg btn-primary pull-xs-right"
							type="submit"
							disabled={ in-progress }
						>
							Update Settings
						</button>
					</fieldset>
				</form>

				<hr />

				<button class="btn btn-outline-danger" on:click={ logout }> Or click here to logout. </button>
			</div>
		</div>
	</div>
</div>
