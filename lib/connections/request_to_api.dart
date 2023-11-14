import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mypetcare/connections/request_options.dart';
import 'package:mypetcare/connections/response_api.dart';

// android -> 10.0.2.2
// web -> localhost
const String url = 'http://localhost';

http.Response errorFunction(error) {
  print("error: ${error.toString()} .");
  return http.Response('{"error": "No se pudo conectar al servidor"}', 800);
}

Future<ApiResponse> fetchFromApi(RequestOptions options) async {
  http.Response response;
  switch (options.method) {
    case HttpMethods.get:
      response = await http.get(
          Uri.parse(url + options.path + options.queryParameters),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${options.bearier}',
            'Content-Type': 'application/json; charset=UTF-8',
          }).catchError(errorFunction);
      break;

    case HttpMethods.post:
      response = await http
          .post(Uri.parse(url + options.path + options.queryParameters),
              headers: {
                HttpHeaders.authorizationHeader: 'Bearer ${options.bearier}',
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: options.body)
          .catchError(errorFunction);
      break;

    case HttpMethods.put:
      response = await http
          .put(Uri.parse(url + options.path + options.queryParameters),
              headers: {
                HttpHeaders.authorizationHeader: 'Bearer ${options.bearier}',
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: options.body)
          .catchError(errorFunction);
      break;

    case HttpMethods.delete:
      response = await http
          .delete(Uri.parse(url + options.path + options.queryParameters),
              headers: {
                HttpHeaders.authorizationHeader: 'Bearer ${options.bearier}',
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: options.body)
          .catchError(errorFunction);
      break;

    case HttpMethods.patch:
      response = await http
          .patch(Uri.parse(url + options.path + options.queryParameters),
              headers: {
                HttpHeaders.authorizationHeader: 'Bearer ${options.bearier}',
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: options.body)
          .catchError(errorFunction);
      break;

    default:
      // basic get
      response = await http.get(
          Uri.parse(url + options.path + options.queryParameters),
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${options.bearier}',
            'Content-Type': 'application/json; charset=UTF-8',
          }).catchError(errorFunction);
      break;
  }
  // end switch
  if (response.statusCode >= 200 && response.statusCode <= 299) {
    print("response.statusCode: ${response.statusCode}");
    return ApiResponse(body: response.body, statusCode: response.statusCode);
  } else {
    print(response.statusCode);
    return ApiResponse(body: response.body, statusCode: response.statusCode);
  }
}
