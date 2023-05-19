// ignore_for_file: unnecessary_getters_setters

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import '../../../application.dart';

import '../../../../shared/env/env.dart';

class UserProvider with ChangeNotifier {
  String _token = '';
  String get token => _token;
  set token(String value) => _token = value;

  late Endpoints _endpoints;
  late HttpClientX _client;

  List<User> loadedUsers = [];
  User loadedUser = User.empty();

  dynamic _dynamicResponse = {};

  UserProvider({required token, required Endpoints endpoints}) {
    _token = token;
    _client = HttpAdapter(endpoint: endpoints);
    _endpoints = endpoints;
  }

  late Map<String, String> headers = {
    "Accept": "application/json",
    "content-type": "application/json",
    "key": "Content-Type",
    "value": "application/json",
    "type": "text",
    "authorization": 'Bearer ' + token,
  };

  // Future<dynamic> getVehicles() async {
  //   var _unencodedPath = _endpoints.getUri(endpoint: _endpoints.getAllUsers);
  //   HttpResponseX response =
  //       await _client.get(uri: _unencodedPath, headers: headers);

  //   if (response.statusCode == HttpStatusCode.success) {
  //     loadedVehicles =
  //         response.body.map<User>((e) => User.fromJson(e)).toList();
  //   } else {
  //     loadedVehicles = [];
  //   }
  // }

  // Future<dynamic> registerUser({required User user}) async {
  //   Map<String, String> header = {
  //     "Accept": "application/json",
  //     "content-type": "application/json",
  //     "key": "Content-Type",
  //     "value": "application/json",
  //     "type": "text"
  //   };
  //   var _uri = _endpoints.getUri(endpoint: _endpoints.register);
  //   HttpResponseX response =
  //       await _client.post(uri: _uri, headers: headers, body: user);

  //   print(response.body.toString());

  //   notifyListeners();
  //   return response.statusCode;
  // }

  Future<dynamic> registerUser({required User user}) async {
    Uri uri = _endpoints.generateUri(endpoint: _endpoints.register);

    try {
      var response = await http
          .post(uri, headers: headers, body: jsonEncode(user))
          .timeout(
        const Duration(seconds: EnvironmentConstants.timeOutException),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> rawJson = jsonDecode(response.body);
        token = rawJson['token'];
        _dynamicResponse = {'statusCode': response.statusCode, 'body': token};
      } else if (response.statusCode == 403) {
        _dynamicResponse = {
          'statusCode': response.statusCode,
          'body': "Não foi possivel salvar o usuário!"
        };
      } else if (response.statusCode == 408) {
        _dynamicResponse = {
          'statusCode': response.statusCode,
          'body': "O servidor não responde."
        };
      }
    } catch (e) {
      _dynamicResponse = {'statusCode': 'X', 'body': e.toString()};
    }
    notifyListeners();
    return Future.value(_dynamicResponse);
  }
}
