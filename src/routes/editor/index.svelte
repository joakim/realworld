<script context="module">
	load: ([ :session ]) -> [ status: 302, redirect: '/login' ] if session.user else []
	
	(load)
</script>

<script>
	(default as Editor): import './_Editor.svelte'
	
	let article: [ title: '', description: '', body: '', tagList: array[] ]
</script>

<Editor { article }/>
