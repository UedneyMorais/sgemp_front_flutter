// ignore_for_file: use_build_context_synchronously, no_leading_underscores_for_local_identifiers, unnecessary_getters_setters, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '/application/application.dart';
import '../../../../shared/env/env.dart';

class AuthorityProvider with ChangeNotifier {
  String _token = '';
  String get token => _token;
  set token(String value) => _token = value;

  bool islogged = false;

  late Endpoints _endpoints;

  late Map<String, String> headers = {
    "Accept": "application/json",
    "content-type": "application/json",
    "key": "Content-Type",
    "value": "application/json",
    "type": "text",
    "authorization": 'Bearer ' + token,
  };

  AuthorityProvider({token, required Endpoints endpoints}) {
    _endpoints = endpoints;
  }

  Future<dynamic> login(
      {required BuildContext context,
      required String email,
      required String password}) async {
    Uri uri = _endpoints.generateUri(endpoint: _endpoints.login);

    String loginBody = jsonEncode({"email": email, "password": password});

    dynamic _dynamicResponse = {};

    try {
      var response =
          await http.post(uri, headers: headers, body: loginBody).timeout(
        const Duration(seconds: EnvironmentConstants.timeOutException),
        onTimeout: () {
          return http.Response('Error', 408);
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> rawJson = jsonDecode(response.body);
        token = rawJson['token'];

        _dynamicResponse = {'statusCode': response.statusCode, 'body': ''};
        notifyListeners();
      } else if (response.statusCode == 403) {
        _dynamicResponse = {
          'statusCode': response.statusCode,
          'body': "E-mail ou senha inválidos!"
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

  logoff({required BuildContext context}) async {
    token = '';
    islogged = false;
    Provider.of<UserProvider>(context, listen: false).loggedUser = User.empty();
  }
}
