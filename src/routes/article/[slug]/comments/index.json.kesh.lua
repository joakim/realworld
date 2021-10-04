api: import '$lib/api.js'

get: async ([ :params, :locals ]) ->
	[:slug]: params
	[:comments]: await api.get(
		"articles/{ slug }/comments"
		locals.user? and locals.user.token?
	)
	[ body: comments ]

post: async ([ :params, body as form, :headers, :locals ]) ->
	if not locals.user?
		return [ status: 401 ]
	
	[:slug]: params
	body: form.get 'comment'
	
	[:comment]: await api.post(
		"articles/{ slug }/comments"
		[ comment: [ :body ] ]
		locals.user.token
	)
	
	-- for AJAX requests, return the newly created comment
	if headers.accept = 'application/json'
		return [ status: 201, body: comment ]

	-- for traditional (no-JS) form submissions, redirect
	-- back to the article page
	print "redirecting to /article/{ slug }"
	
	[ status: 303, headers: [ location: "/article/{ slug }" ] ]

(get, post)
