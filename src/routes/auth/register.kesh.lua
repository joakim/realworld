api: import '$lib/api.js'
(respond): import './_respond'

post: async (request) ->
	user: request.body
	
	-- TODO individual properties
	body: await api.post('users', [ :user ])
	
	respond body

(post)
