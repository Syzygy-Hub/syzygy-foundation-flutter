enum NetworkMethod {
  get('GET'),
  post('POST'),
  put('PUT'),
  patch('PATCH'),
  delete('DELETE'),
  head('HEAD');

  final String value;
  const NetworkMethod(this.value);
}
