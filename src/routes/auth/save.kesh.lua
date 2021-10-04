api: import '$lib/api.js'
(respond): import './_respond'

post: async ([ body as user, :locals ]) ->
	if not locals.user?
		return [ status: 401 ]
	
	[:token]: locals.user
	body: await api.put(
		'user'
		[:user] -- TODO individual properties
		token
	)
	
	respond body
