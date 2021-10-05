<script context="module">
	load: async [page, fetch] ->
		res: await fetch "/profile/@{ page.params.user }.json"
		profile: await res.json()
		
		(props: (profile))
	
	(load)
</script>

<script>
	(page, session): import '$app/stores'
	
	let profile
	
	-- TODO would be nice to have a more idiomatic solution to this —
	-- https://github.com/sveltejs/kit/issues/269
	$ segments: $page.path.split '/'
	$ is-favorites: segments.length = 4 and segments.3 = 'favorites'
	$ is-user: $session.user and profile.username = $session.user.username
	
	let current-token
	toggle-following: async () *->
		token: { set current-token: [] }
		
		[following, username]: profile
		
		-- optimistic UI
		set profile.following: not profile.following
		
		res: await fetch("/profile/@{ username }/follow", [
			method: 'delete' if following else 'post'
		])
		
		result: await res.json()
		
		-- synchronise with the server, in case it disagrees
		-- with our optimistic UI for some reason — but only
		-- if the button wasn't re-toggled in the meantime
		if token = current-token
			set profile: result.profile
	
	(profile)
</script>

<svelte:head>
	<title>{ profile.username } • Conduit</title>
</svelte:head>

<div class="profile-page">
	<div class="user-info">
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-md-10 offset-md-1">
					<img src={ profile.image } class="user-img" alt={ profile.username } />
					<h4>{ profile.username }</h4>
					<p>{ profile.bio }</p>

					{#if is-user}
						<a href="/settings" class="btn btn-sm btn-outline-secondary action-btn">
							<i class="ion-gear-a" />
							Edit Profile Settings
						</a>
					{:else if $session.user}
						<button
							class="btn btn-sm action-btn { 'btn-secondary' if profile.following else 'btn-outline-secondary' }"
							on:click={ toggle-following }
						>
							<i class="ion-plus-round" />
							{ 'Unfollow' if profile.following else 'Follow' }
							{ profile.username }
						</button>
					{:else}<a href="/login">Sign in to follow</a>{/if}
				</div>
			</div>
		</div>
	</div>

	<div class="container">
		<div class="row">
			<div class="col-xs-12 col-md-10 offset-md-1">
				<div class="articles-toggle">
					<ul class="nav nav-pills outline-active">
						<li class="nav-item">
							<a
								href="/profile/@{ profile.username }"
								class="nav-link"
								rel="prefetch"
								class:active={ not is-favorites }
							>Articles</a>
						</li>

						<li class="nav-item">
							<a
								href="/profile/@{ profile.username }/favorites"
								class="nav-link"
								rel="prefetch"
								class:active={ is-favorites }
							>Favorites</a>
						</li>
					</ul>
				</div>

				<slot />
			</div>
		</div>
	</div>
</div>
