api: '$lib/api.js'

post: async [params, locals] -> [
	body: await api.post("profiles/{ params.user }/follow", null, locals.user.token)
]

del: async [params, locals] -> [
	body: await api.del("profiles/{ params.user }/follow", locals.user.token)
]

(post, del)
