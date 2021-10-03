cookie: import 'cookie'

handle: async ([ :request, :resolve ]) ->
	cookies: cookie.parse(request.headers.cookie ? '')
	jwt: cookies.jwt and Buffer.from(cookies.jwt, 'base64').toString('utf-8')
	set request.locals.user: JSON.parse(jwt) if jwt? else null
	await resolve request

get-session: ([ :locals ]) -> [
	user: locals.user and {
		username: locals.user.username
		email: locals.user.email
		image: locals.user.image
		bio: locals.user.bio
	]
]

(handle, get-session)
