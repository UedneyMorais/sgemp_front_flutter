import 'dart:typed_data';

import 'http_statuscodes.dart';

class HttpResponseX {
  late HttpStatusCode statusCode;
  late dynamic body;
  late Uint8List? bodyBytes;
  late Map<String, String>? headers;

  HttpResponseX(
      {required this.statusCode, this.body, this.headers, this.bodyBytes});
}
