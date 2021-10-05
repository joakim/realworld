cookie: import 'cookie'

handle: async [request, resolve] ->
	cookies: cookie.parse(request.headers.cookie ? '')
	jwt: if cookies.jwt?
		Buffer.from(cookies.jwt, 'base64').toString('utf-8')
	set request.locals.user: if jwt?
		JSON.parse jwt
	
	await resolve request

get-session: [locals] -> [
	user: if locals.user?
		[
			username: locals.user.username
			email: locals.user.email
			image: locals.user.image
			bio: locals.user.bio
		]
]

(handle, get-session)
