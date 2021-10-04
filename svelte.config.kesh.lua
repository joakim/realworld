(default as netlify): import '@sveltejs/adapter-netlify'
(default as vercel): import '@sveltejs/adapter-vercel'

default: [
	kit:
		adapter: vercel() if process.env.VERCEL else netlify()
		target: '#svelte'
]

(default)
