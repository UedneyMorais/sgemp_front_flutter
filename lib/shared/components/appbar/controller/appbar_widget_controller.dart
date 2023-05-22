import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgemp_front_flutter/application/application.dart';
import 'package:sgemp_front_flutter/application/domain/login/entities/login.dart';

import '../../../../ui/ui.dart';

class AppBarWidgetController {
  logoff({required BuildContext context}) {
    Provider.of<AuthorityProvider>(context, listen: false)
        .logoff(context: context);

    Navigator.of(context).pushReplacement(MaterialPageRoute<Login>(
      builder: (BuildContext context) {
        return LoginPage();
      },
    ));
  }
}
