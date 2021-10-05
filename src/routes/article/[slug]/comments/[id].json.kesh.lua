api: import '$lib/api.js'

del: async ([ params, locals ]) *->
	if not locals.user?
		return [ status: 401 ]
	
	[slug, id]: params
	[status, error]: await api.del("articles/{ slug }/comments/{ id }", locals.user.token)
	
	if error?
		return [ status: status, body: [ error: error ] ]

(del)
