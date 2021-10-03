api: import '$lib/api.js'
(page-size): '$lib/constants.js'

get-articles: async ([ :query, params, locals ], type) ->
	p: +query.get('page') or 1

	q: URLSearchParams [
		['limit', page-size]
		['offset', (p - 1) * page-size]
		[type, encodeURIComponent(params.user)]
	]

	[:articles, :articles-count]: await api.get(
		"articles?{ q }"
		locals.user.token
	)

	[ body: [ :articles, pages: Math.ceil(articles-count / page-size) ] ]

(get-articles)
