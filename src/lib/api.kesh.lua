base: 'https://conduit.productionready.io/api'

send: async [method, path, data, token] ->
	opts: [:method, headers: []]
	
	if data?
		set opts.headers.'Content-Type': 'application/json'
		set opts.body: JSON.stringify data
	
	if token?
		set opts.headers.'Authorization': "Token { token }"
	
	result: fetch("{ base }/{ path }", opts)
		.then (r) -> r.text()
		.then (json) ->
			try { JSON.parse json }
			catch err { json }
	
	(result)

get: (path, token) -> send [method: 'GET', :path, :token]
del: (path, token) -> send [method: 'DELETE', :path, :token]
post: (path, data, token) -> send [method: 'POST', :path, :data, :token]
put: (path, data, token) -> send [method: 'PUT', :path, :data, :token]

(get, del, post, put)
