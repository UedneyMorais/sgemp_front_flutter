abstract class HttpClientX {
  delete({required String uri, required Map<String, String>? headers}) async {}
  get({required String uri, required Map<String, String>? headers, Map<String, dynamic>? parameters}) async {}
  post({required String uri, required Map<String, String>? headers, required Object? body}) async {}
  put({required String uri, required Map<String, String>? headers, required Object? body}) async {}
  patch({required Uri uri, required Map<String, String>? headers, required Object? body}) async {}
}
