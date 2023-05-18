// ignore_for_file: unnecessary_statements

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../../../shared/env/env.dart';
import '../../infrastructure.dart';

class HttpAdapter extends HttpOverrides implements HttpClientX {
  late Endpoints endpoints;

  HttpAdapter({BuildContext? context, Endpoints? endpoint}) {
    endpoints = endpoint!;
  }

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }

  evaluateBodyBytes(apiResponse) {
    if (apiResponse.bodyBytes.runtimeType == Uint8List) {
      var bodyBytes = jsonDecode(utf8.decode(apiResponse.bodyBytes));
      return bodyBytes;
    } else {
      return apiResponse.bodyBytes;
    }
  }

  evaluateBody(apiResponse) {
    try {
      var convertedBodyBytes = (apiResponse.bodyBytes) as List<int>;
      var body = jsonDecode(utf8.decode(convertedBodyBytes));
      return body;
    } catch (e) {
      apiResponse.body;
    }
  }

  @override
  Future<HttpResponseX> delete(
      {required String uri, Map<String, String>? headers, Object? body}) async {
    Uri url = EnvironmentConstants.useHttps
        ? Uri.https(endpoints.autorith, uri)
        : Uri.http(endpoints.autorith, uri);

    late HttpResponseX response;
    try {
      http.Response apiResponse = await http
          .delete(url, body: jsonEncode(body), headers: headers)
          .timeout(
              const Duration(seconds: EnvironmentConstants.timeOutException));
      if (apiResponse.statusCode == 200) {
        response = HttpResponseX(
            statusCode: HttpStatusCode.success,
            headers: apiResponse.headers,
            body: evaluateBody(apiResponse),
            bodyBytes: evaluateBodyBytes(apiResponse));
      } else if (apiResponse.statusCode == 201) {
        response = HttpResponseX(
            statusCode: HttpStatusCode.created,
            headers: apiResponse.headers,
            body: evaluateBody(apiResponse),
            bodyBytes: evaluateBodyBytes(apiResponse));
      } else if (apiResponse.statusCode == 400) {
        response = HttpResponseX(
            statusCode: HttpStatusCode.badRequest,
            headers: apiResponse.headers,
            body: evaluateBody(apiResponse),
            bodyBytes: evaluateBodyBytes(apiResponse));
      } else if (apiResponse.statusCode == 403) {
        response = HttpResponseX(
            statusCode: HttpStatusCode.forbidden,
            headers: apiResponse.headers,
            body: evaluateBody(apiResponse),
            bodyBytes: evaluateBodyBytes(apiResponse));
      } else if (apiResponse.statusCode == 404) {
        response = HttpResponseX(
            statusCode: HttpStatusCode.notFound,
            headers: apiResponse.headers,
            body: evaluateBody(apiResponse),
            bodyBytes: evaluateBodyBytes(apiResponse));
      } else if (apiResponse.statusCode == 415) {
        response = HttpResponseX(
            statusCode: HttpStatusCode.unsupportedMediaType,
            headers: apiResponse.headers,
            body: evaluateBody(apiResponse),
            bodyBytes: evaluateBodyBytes(apiResponse));
      } else if (apiResponse.statusCode == 500) {
        response = HttpResponseX(
            statusCode: HttpStatusCode.internalServerError,
            headers: apiResponse.headers,
            body: evaluateBody(apiResponse),
            bodyBytes: evaluateBodyBytes(apiResponse));
      } else {
        response = HttpResponseX(
            statusCode: HttpStatusCode.unImplementedError,
            body: apiResponse.body,
            bodyBytes: apiResponse.bodyBytes);
      }
      return Future.value(response);
    } on TimeoutException catch (e) {
      response = HttpResponseX(statusCode: HttpStatusCode.timeOut, body: e);
      return Future.value(response);
    }
  }

  @override
  Future<HttpResponseX> get(
      {required String uri,
      required Map<String, String>? headers,
      Map<String, dynamic>? parameters}) async {
    Uri url = EnvironmentConstants.useHttps
        ? Uri.https(endpoints.autorith, uri, parameters)
        : Uri.http(endpoints.autorith, uri, parameters);
    late HttpResponseX response;

    try {
      http.Response apiResponse = await http.get(url, headers: headers).timeout(
          const Duration(seconds: EnvironmentConstants.timeOutException));
      if (apiResponse.statusCode == 200) {
        response = HttpResponseX(
            statusCode: HttpStatusCode.success,
            headers: apiResponse.headers,
            body: evaluateBody(apiResponse),
            bodyBytes: evaluateBodyBytes(apiResponse));
      } else if (apiResponse.statusCode == 201) {
        response = HttpResponseX(
            statusCode: HttpStatusCode.created,
            headers: apiResponse.headers,
            body: evaluateBody(apiResponse),
            bodyBytes: evaluateBodyBytes(apiResponse));
      } else if (apiResponse.statusCode == 400) {
        response = HttpResponseX(
            statusCode: HttpStatusCode.badRequest,
            headers: apiResponse.headers,
            body: evaluateBody(apiResponse),
            bodyBytes: evaluateBodyBytes(apiResponse));
      } else if (apiResponse.statusCode == 403) {
        response = HttpResponseX(
            statusCode: HttpStatusCode.forbidden,
            headers: apiResponse.headers,
            body: evaluateBody(apiResponse),
            bodyBytes: evaluateBodyBytes(apiResponse));
      } else if (apiResponse.statusCode == 404) {
        response = HttpResponseX(
            statusCode: HttpStatusCode.notFound,
            headers: apiResponse.headers,
            body: evaluateBody(apiResponse),
            bodyBytes: evaluateBodyBytes(apiResponse));
      } else if (apiResponse.statusCode == 415) {
        response = HttpResponseX(
            statusCode: HttpStatusCode.unsupportedMediaType,
            headers: apiResponse.headers,
            body: evaluateBody(apiResponse),
            bodyBytes: evaluateBodyBytes(apiResponse));
      } else if (apiResponse.statusCode == 500) {
        response = HttpResponseX(
            statusCode: HttpStatusCode.internalServerError,
            headers: apiResponse.headers,
            body: evaluateBody(apiResponse),
            bodyBytes: evaluateBodyBytes(apiResponse));
      } else {
        response = HttpResponseX(
            statusCode: HttpStatusCode.unImplementedError,
            body: apiResponse.body,
            bodyBytes: apiResponse.bodyBytes);
      }
      return Future.value(response);
    } on TimeoutException catch (e) {
      response = HttpResponseX(statusCode: HttpStatusCode.timeOut, body: e);

      return Future.value(response);
    }
  }

  @override
  Future<HttpResponseX> post(
      {required String uri, Map<String, String>? headers, Object? body}) async {
    Uri url = EnvironmentConstants.useHttps
        ? Uri.https(endpoints.autorith, uri)
        : Uri.http(endpoints.autorith, uri);

    late HttpResponseX response;
    try {
      http.Response apiResponse = await http
          .post(url, body: jsonEncode(body), headers: headers)
          .timeout(
              const Duration(seconds: EnvironmentConstants.timeOutException));
      if (apiResponse.statusCode == 200) {
        response = HttpResponseX(
            statusCode: HttpStatusCode.success,
            headers: apiResponse.headers,
            body: evaluateBody(apiResponse),
            bodyBytes: evaluateBodyBytes(apiResponse));
      } else if (apiResponse.statusCode == 201) {
        response = HttpResponseX(
            statusCode: HttpStatusCode.created,
            headers: apiResponse.headers,
            body: evaluateBody(apiResponse),
            bodyBytes: evaluateBodyBytes(apiResponse));
      } else if (apiResponse.statusCode == 400) {
        response = HttpResponseX(
            statusCode: HttpStatusCode.badRequest,
            headers: apiResponse.headers,
            body: evaluateBody(apiResponse),
            bodyBytes: evaluateBodyBytes(apiResponse));
      } else if (apiResponse.statusCode == 403) {
        response = HttpResponseX(
            statusCode: HttpStatusCode.forbidden,
            headers: apiResponse.headers,
            body: evaluateBody(apiResponse),
            bodyBytes: evaluateBodyBytes(apiResponse));
      } else if (apiResponse.statusCode == 404) {
        response = HttpResponseX(
            statusCode: HttpStatusCode.notFound,
            headers: apiResponse.headers,
            body: evaluateBody(apiResponse),
            bodyBytes: evaluateBodyBytes(apiResponse));
      } else if (apiResponse.statusCode == 415) {
        response = HttpResponseX(
            statusCode: HttpStatusCode.unsupportedMediaType,
            headers: apiResponse.headers,
            body: evaluateBody(apiResponse),
            bodyBytes: evaluateBodyBytes(apiResponse));
      } else if (apiResponse.statusCode == 500) {
        response = HttpResponseX(
            statusCode: HttpStatusCode.internalServerError,
            headers: apiResponse.headers,
            body: evaluateBody(apiResponse),
            bodyBytes: evaluateBodyBytes(apiResponse));
      } else {
        response = HttpResponseX(
            statusCode: HttpStatusCode.unImplementedError,
            body: apiResponse.body,
            bodyBytes: apiResponse.bodyBytes);
      }
      return Future.value(response);
    } on TimeoutException catch (e) {
      response = HttpResponseX(statusCode: HttpStatusCode.timeOut, body: e);
      return Future.value(response);
    }
  }

  @override
  put(
      {required String uri,
      required Map<String, String>? headers,
      required Object? body}) async {
    late HttpResponseX response;
    Uri url = EnvironmentConstants.useHttps
        ? Uri.https(endpoints.autorith, uri)
        : Uri.http(endpoints.autorith, uri);

    try {
      http.Response apiResponse = await http
          .put(url, body: jsonEncode(body), headers: headers)
          .timeout(
              const Duration(seconds: EnvironmentConstants.timeOutException));
      if (apiResponse.statusCode == 200) {
        response = HttpResponseX(
            statusCode: HttpStatusCode.success,
            headers: apiResponse.headers,
            body: evaluateBody(apiResponse),
            bodyBytes: evaluateBodyBytes(apiResponse));
      } else if (apiResponse.statusCode == 201) {
        response = HttpResponseX(
            statusCode: HttpStatusCode.created,
            headers: apiResponse.headers,
            body: evaluateBody(apiResponse),
            bodyBytes: evaluateBodyBytes(apiResponse));
      } else if (apiResponse.statusCode == 400) {
        response = HttpResponseX(
            statusCode: HttpStatusCode.badRequest,
            headers: apiResponse.headers,
            body: evaluateBody(apiResponse),
            bodyBytes: evaluateBodyBytes(apiResponse));
      } else if (apiResponse.statusCode == 403) {
        response = HttpResponseX(
            statusCode: HttpStatusCode.forbidden,
            headers: apiResponse.headers,
            body: evaluateBody(apiResponse),
            bodyBytes: evaluateBodyBytes(apiResponse));
      } else if (apiResponse.statusCode == 404) {
        response = HttpResponseX(
            statusCode: HttpStatusCode.notFound,
            headers: apiResponse.headers,
            body: evaluateBody(apiResponse),
            bodyBytes: evaluateBodyBytes(apiResponse));
      } else if (apiResponse.statusCode == 415) {
        response = HttpResponseX(
            statusCode: HttpStatusCode.unsupportedMediaType,
            headers: apiResponse.headers,
            body: evaluateBody(apiResponse),
            bodyBytes: evaluateBodyBytes(apiResponse));
      } else if (apiResponse.statusCode == 500) {
        response = HttpResponseX(
            statusCode: HttpStatusCode.internalServerError,
            headers: apiResponse.headers,
            body: evaluateBody(apiResponse),
            bodyBytes: evaluateBodyBytes(apiResponse));
      } else {
        response = HttpResponseX(
            statusCode: HttpStatusCode.unImplementedError,
            body: apiResponse.body,
            bodyBytes: apiResponse.bodyBytes);
      }
      return Future.value(response);
    } on TimeoutException catch (e) {
      response = HttpResponseX(statusCode: HttpStatusCode.timeOut, body: e);
      return Future.value(response);
    }
  }

  @override
  patch(
      {required Uri uri,
      required Map<String, String>? headers,
      required Object? body}) {
    throw UnimplementedError();
  }

  paginatedSearch(
      {required String url,
      required String searchedValue,
      required int numberOfResults,
      required int pageNumber,
      String? orderBy,
      String? direction}) async {
    String token =
        'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJyb2lAZ21haWwuY29tIiwiYXVkIjoiMSIsImV4cCI6MTY0NDE0Njg0M30.Opdi1aw_L33C7O4Z8Et-jyS9AKRI4rTjKj0RCKUGYJ6wM1zrPvEkQkrOFFqdpOKBsX4bUJUaqbELbcHEXSog8Q';
    Map<String, String>? headers = {
      "Accept": "application/json",
      "content-type": "application/json",
      "key": "Content-Type",
      "value": "application/json",
      "type": "text",
      "authorization": 'Bearer $token',
    };
    Map<String, String>? parameters = {
      "q": searchedValue,
      "page": pageNumber.toString(),
      "linesPerPage": numberOfResults.toString(),
      "OrderBy": orderBy!,
      "direction": direction!
    };
    var response =
        await get(uri: url, headers: headers, parameters: parameters);

    return Future.value(response);
  }
}
