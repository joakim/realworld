api: import '$lib/api'
(page_size): import '$lib/constants'

get: async ([ :query, :locals ]) -> {
	tab: query.get('tab') or 'all'
	tag: query.get('tag')
	page: +query.get('page') or 1
	
	endpoint: 'articles/feed' if tab = 'feed' else 'articles'
	
	q: URLSearchParams()
	
	q.set('limit', page_size)
	q.set('offset', (page - 1) * page_size)
	
	if tag {
		q.set('tag', tag)
	}
	
	[ :articles, :articlesCount ]: await api.get(
		"{endpoint}?{q}"
		locals.user and locals.user.token
	)
	
	[
		body:
			:articles
			pages: Math.ceil(articlesCount / page_size)
	]
}

(get)
