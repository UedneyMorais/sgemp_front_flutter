// ignore_for_file: use_build_context_synchronously, unnecessary_new

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sgemp_front_flutter/application/application.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/components/components.dart';
import '../../../shared/env/env.dart';
import '../../ui.dart';

class LoginController {
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();

  bool isPasswordVisible = false;
  bool rememberEmail = false;
  bool isLoading = false;

  late SharedPreferences prefs;

  startSettings() async {
    await startPreferences();
    await readSharedPreferences();
  }

  Future<void> startPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  readSharedPreferences() async {
    final email = prefs.getString('email');
    final rbEmail = prefs.getBool('rememberEmail');

    if (email != null && rbEmail != null) {
      rememberEmail = rbEmail;
      textEditingControllerEmail.text = email;
    }
  }

  setPreferences({required String email, required bool rememberEmail}) async {
    await prefs.setString('email', email);
    await prefs.setBool('rememberEmail', rememberEmail);
    await readSharedPreferences();
  }

  login(
      {required GlobalKey<FormState> formKey,
      required BuildContext context}) async {
    String email = textEditingControllerEmail.text;
    String password = textEditingControllerPassword.text;
    if (formKey.currentState!.validate()) {
      var result = await Provider.of<AuthorityProvider>(context, listen: false)
          .login(context: context, email: email, password: password);

      if (result != null && result['statusCode'] == 200) {
        Navigator.of(context).pushReplacement(MaterialPageRoute<Home>(
          builder: (BuildContext context) {
            return const Home(
                // email: email,
                );
          },
        ));
      } else if (result != null && result['statusCode'] != 200) {
        SnackbarWidget.showSnackBar(context,
            text: result['body'].toString(),
            duration: EnvironmentConstants.snackBarDuration);
      }
    }
  }

  validateEmail({required dynamic value}) {
    if (value == null || value.isEmpty) {
      return 'O campo e-mail está vazio!';
    }
    if (!value.contains("@") || !value.contains(".")) {
      return 'E-mail inválido!';
    }
    return null;
  }

  validatePassword({required dynamic value}) {
    if (value == null || value.isEmpty) {
      return 'O campo senha está vazio!';
    }
    if (value.length < 6) {
      return 'A senha digitada é muito pequena!';
    }
    return null;
  }

  createNewUser(
      {required GlobalKey<FormState> formKey, required BuildContext context}) {
    Navigator.of(context).push(MaterialPageRoute<Home>(
      builder: (BuildContext context) {
        return NewUser();
      },
    ));
  }
}
