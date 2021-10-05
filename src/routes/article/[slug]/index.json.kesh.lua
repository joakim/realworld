api: import '$lib/api.js'

get: async [params, locals] ->
	[slug]: params
	[article]: await api.get("articles/{ slug }", locals.user.token)
	
	[ body: article ]

put: async (request) *->
	print('put', request)

(get, put)
