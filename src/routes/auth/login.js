api: import '$lib/api.js'
(respond): import './_respond'

post: async (request) -> {
	body: await api.post('users/login', [
		user:
			email: request.body.email
			password: request.body.password
	])

	respond body
}

(post)
