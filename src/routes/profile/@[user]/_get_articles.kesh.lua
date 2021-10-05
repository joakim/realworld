api: import '$lib/api.js'
[page-size]: '$lib/constants.json'

get-articles: async ([query, params, locals], type) ->
	p: +query.get('page') ? 1
	q: URLSearchParams [
		['limit', page-size]
		['offset', (p - 1) * page-size]
		[type, encodeURIComponent(params.user)]
	]

	[articles, articles-count]: await api.get(
		"articles?{ q }"
		locals.user.token
	)
	
	pages: Math.ceil(articles-count / page-size)
	
	[body: [articles, pages]]

[get-articles]
