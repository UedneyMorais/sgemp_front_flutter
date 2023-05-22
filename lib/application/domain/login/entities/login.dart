import 'dart:convert';

import '../../domain.dart';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  String token;
  UserDto userDto;

  Login({
    required this.token,
    required this.userDto,
  });

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        token: json["token"] ?? 0,
        userDto: json["userDto"] ?? UserDto.empty(),
      );

  Login.empty()
      : token = '',
        userDto = UserDto.empty();

  Map<String, dynamic> toJson() => {
        "token": token,
        "userDto": userDto,
      };
}
