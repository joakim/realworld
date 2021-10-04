post: (endpoint, data) ->
	fetch(endpoint, [
		method: 'POST'
		credentials: 'include'
		body: JSON.stringify(data or [])
		headers:
			'Content-Type': 'application/json'
	]).then (r) -> r.json()

(post)
