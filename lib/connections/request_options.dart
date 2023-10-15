class RequestOptions {
  final HttpMethods method;
  final String path;
  final String bearier;
  final String queryParameters;
  final String body;
  /*
  method : HttpMethods enum
  path : string with path ej "/users"
  bearier : token in string ej  "asdkfjasdjf23..."
  queryParameters : strink like "?key=value&key2=value2"
  body : string with json format (use jsonEncode in a object) option not available in get method
   */
  RequestOptions({
    this.method = HttpMethods.get,
    required this.path,
    this.bearier = '',
    this.queryParameters = '',
    this.body = '{}',
  });
}
enum HttpMethods {
  get,
  post,
  put,
  delete,
  patch,
} 