<script context="module">
	load: [session] -> (
		status: 302
		redirect: "/profile/@{ session.user.username }" if session.user? else '/login'
	)
	
	(load)
</script>
