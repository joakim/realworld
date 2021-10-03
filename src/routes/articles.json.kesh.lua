api: import '$lib/api'
(page-size): import '$lib/constants'

get: async ([ :query, :locals ]) ->
	tab: query.get('tab') or 'all'
	tag: query.get('tag')
	page: +query.get('page') or 1
	
	endpoint: 'articles/feed' if tab = 'feed' else 'articles'
	
	q: URLSearchParams()
	
	q.set('limit', page-size)
	q.set('offset', (page - 1) * page-size)
	
	if tag? -> q.set('tag', tag)
	
	[ :articles, :articles-count ]: await api.get(
		"{endpoint}?{q}"
		locals.user.token
	)
	
	[ body: [ :articles, pages: Math.ceil(articles-count / page-size) ] ]

(get)
