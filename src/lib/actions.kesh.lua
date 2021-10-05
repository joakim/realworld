no-op: () -> ()

ajax: (node, [on-submit ? no-op, on-response ? no-op] ? []) ->
	handler: async (event) *->
		event.preventDefault()
		body: FormData(node) if node.method = 'post' or node.method = 'put' else null
		
		on-submit body
		
		response: await fetch(node.action, [
			method: node.method
			:body
			headers:
				accept: 'application/json'
		])
		
		on-response response
	
	node.addEventListener('submit', handler)
	
	(destroy: () *-> node.removeEventListener('submit', handler))

(ajax)
