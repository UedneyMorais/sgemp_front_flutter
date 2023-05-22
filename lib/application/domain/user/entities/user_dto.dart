import 'dart:convert';

UserDto userDtoFromJson(String str) => UserDto.fromJson(json.decode(str));

String userDtoToJson(UserDto data) => json.encode(data.toJson());

class UserDto {
  int id;
  String firstname;
  String lastname;
  String email;
  String role;
  bool enabled;
  bool accountNonExpired;
  bool accountNonLocked;
  bool credentialsNonExpired;

  UserDto({
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

  factory UserDto.fromJson(Map<String, dynamic> json) => UserDto(
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

  UserDto.empty()
      : id = 0,
        firstname = '',
        lastname = '',
        email = '',
        role = 'USER',
        enabled = true,
        accountNonExpired = true,
        accountNonLocked = true,
        credentialsNonExpired = true;

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
