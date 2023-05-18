// ignore_for_file: null_argument_to_non_null_type

import '../http.dart';

abstract class HttpClientX {
  Future<HttpResponseX> delete(
      {required String uri, Map<String, String>? headers, Object? body}) async {
    return Future.value();
  }

  Future<HttpResponseX> get(
      {required String uri,
      Map<String, String>? headers,
      Map<String, String>? parameters}) async {
    return Future.value();
  }

  Future<HttpResponseX> post(
      {required String uri, Map<String, String>? headers, Object? body}) async {
    return Future.value();
  }

  Future<HttpResponseX> put(
      {required String uri, Map<String, String>? headers, Object? body}) async {
    return Future.value();
  }
}
