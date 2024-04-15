addEventListener('fetch', event => {
    event.respondWith(handleRequest(event.request))
  })
  
  async function handleRequest(request) {
    let response = await fetch(request)
  
    // Add Cross-Origin Isolation header
    response = new Response(response.body, response)
    response.headers.set('Cross-Origin-Isolation', 'require-corp')
  
    // Add SharedArrayBuffer header
    response.headers.set('SharedArrayBuffer', 'true')
  
    return response
  }
  