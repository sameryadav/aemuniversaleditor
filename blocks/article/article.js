/*export default async function decorate(block) {
  const cfPath = block.dataset.cfPath || block.getAttribute('data-cf-path');
  if (!cfPath) {
    block.textContent = 'No Content Fragment path provided.';
    return;
  }
  const endpoint = '/content/_cq_graphql/endpoint.json';
  const query = `
    query GetArticle($path: String!) {
      articleList(filter: { _path: { _expressions: [{ value: $path }] } }) {
        items {
          title
          summary
          body
        }
      }
    }
  `;
  let data;
  try {
    const res = await fetch(endpoint, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ query, variables: { path: cfPath } }),
    });
    const json = await res.json();
    data = json.data.articleList.items[0];
  } catch (e) {
    block.textContent = 'Failed to fetch article data.';
    return;
  }
  if (!data) {
    block.textContent = 'No article found at the specified path.';
    return;
  }
  block.textContent = `Title: ${data.title || ''}
Summary: ${data.summary || ''}
Body: ${data.body || ''}`;
}*/