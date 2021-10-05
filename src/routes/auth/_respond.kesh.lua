respond: (body) ->
	if body.errors?
		return [ status: 401, :body ]
	
	json: JSON.stringify(body.user)
	value: Buffer
		.from json
		.toString 'base64'
	
	[ headers: 'set-cookie': "jwt={ value }; Path=/; HttpOnly", :body ]

(respond)
