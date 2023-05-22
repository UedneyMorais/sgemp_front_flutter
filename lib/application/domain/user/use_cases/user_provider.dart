// ignore_for_file: unnecessary_getters_setters, prefer_interpolation_to_compose_strings, prefer_typing_uninitialized_variables

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../../application.dart';

import '../../../../shared/env/env.dart';

class UserProvider with ChangeNotifier {
  String _token = '';
  String get token => _token;
  set token(String value) => _token = value;

  late User _loggedUser;
  User get loggedUser => _loggedUser;
  set loggedUser(User value) => _loggedUser = value;

  late Endpoints _endpoints;

  List<User> loadedUsers = [];
  User loadedUser = User.empty();

  dynamic _dynamicResponse = {};

  UserProvider({required token, required Endpoints endpoints}) {
    _token = token;
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

  cleanloggedUser() {
    loggedUser = User.empty();
    notifyListeners();
  }

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

  decodeToken(String token) {
    var decodeToken = JwtDecoder.decode(token);
    return decodeToken;
  }

  Future<dynamic> setLoggedUserByEmail({required String token}) async {
    var email = decodeToken(token)['sub'];

    Uri uri = _endpoints.generateUri(
        endpoint: _endpoints.findUserByEmail.replaceAll('{email}', email));

    try {
      var response = await http.get(uri, headers: headers).timeout(
        const Duration(seconds: EnvironmentConstants.timeOutException),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> rawJson = jsonDecode(response.body);

        _loggedUser = User.fromJson(rawJson);

        _dynamicResponse = {
          'statusCode': response.statusCode,
          'body': _loggedUser
        };
      } else if (response.statusCode == 403) {
        _dynamicResponse = {
          'statusCode': response.statusCode,
          'body': "Não foi possivel encontrar o usuário!"
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
