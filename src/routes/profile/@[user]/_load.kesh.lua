create-load: (endpoint) -> async [page, fetch] ->
	res: await fetch "/profile/@{ page.params.user }/{ endpoint }.json"
	props: await res.json()
	
	[props]

[create-load]
