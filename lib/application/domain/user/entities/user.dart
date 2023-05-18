import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  int id;
  String firstname;
  String lastname;
  String email;
  String role;
  bool enabled;
  bool accountNonExpired;
  bool accountNonLocked;
  bool credentialsNonExpired;

  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.role,
    required this.enabled,
    required this.accountNonExpired,
    required this.accountNonLocked,
    required this.credentialsNonExpired,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? 0,
        firstname: json["firstname"] ?? '',
        lastname: json["lastname"] ?? '',
        email: json["email"] ?? '',
        role: json["role"] ?? '',
        enabled: json["enabled"] ?? 'false',
        accountNonExpired: json["accountNonExpired"] ?? 'false',
        accountNonLocked: json["accountNonLocked"] ?? 'false',
        credentialsNonExpired: json["credentialsNonExpired"] ?? 'false',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "role": role,
        "enabled": enabled,
        "accountNonExpired": accountNonExpired,
        "accountNonLocked": accountNonLocked,
        "credentialsNonExpired": credentialsNonExpired,
      };
}
