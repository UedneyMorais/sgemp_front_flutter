// ignore_for_file: unnecessary_getters_setters

import 'package:flutter/material.dart';

import '../../../application.dart';

import '../../../../shared/env/env.dart';

class UserProvider with ChangeNotifier {
  String _token = '';
  String get token => _token;
  set token(String value) => _token = value;

  late Endpoints _endpoints;
  late HttpClientX _client;

  List<User> loadedUsers = [];
  //VehicleBrand loadedVehicle = VehicleBrand.empty();

  UserProvider({required token, required Endpoints endpoints}) {
    _token = token;
    _client = HttpAdapter(endpoint: _endpoints);
    _endpoints = endpoints;
  }

  late Map<String, String> headers = {
    "Accept": "application/json",
    "content-type": "application/json",
    "key": "Content-Type",
    "value": "application/json",
    "type": "text",
    //"authorization": 'Bearer ' + token,
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
}
