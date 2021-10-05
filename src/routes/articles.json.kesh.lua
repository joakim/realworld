api: import '$lib/api'
(page-size): import '$lib/constants'

get: async [query, locals] ->
	tab: query.get('tab') ? 'all'
	tag: query.get('tag')
	page: #number query.get('page') ? 1
	
	endpoint: 'articles/feed' if tab = 'feed' else 'articles'
	
	q: URLSearchParams()
	
	q.set('limit', page-size)
	q.set('offset', (page - 1) * page-size)
	if tag? { q.set('tag', tag) }
	
	[articles, articles-count]: await api.get(
		"{ endpoint }?{ q }"
		locals.user.token
	)
	
	pages: Math.ceil(articles-count / page-size)
	
	(body: (articles, pages))

(get)
