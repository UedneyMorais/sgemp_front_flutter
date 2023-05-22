import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgemp_front_flutter/application/application.dart';

class HomeController {
  setLoggedUser({required BuildContext context}) async {
    String token = Provider.of<AuthorityProvider>(context, listen: false).token;
    await Provider.of<UserProvider>(context, listen: false)
        .setLoggedUserByEmail(token: token);
  }

  loadInfo({required BuildContext context}) async {
    await setLoggedUser(context: context);
  }
}
