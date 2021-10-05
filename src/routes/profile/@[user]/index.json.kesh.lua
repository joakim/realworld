api: import '$lib/api.js'

get: async [params, locals] ->
	[profile]: await api.get("profiles/{ params.user }", locals.user.token)
	
	[body: profile]

[get]
