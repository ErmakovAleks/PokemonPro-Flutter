enum HttpMethod {
  delete('DELETE'),
  patch('PATCH'),
  post('POST'),
  get('GET'),
  put('PUT');

  final String method;

  const HttpMethod(this.method);
}
