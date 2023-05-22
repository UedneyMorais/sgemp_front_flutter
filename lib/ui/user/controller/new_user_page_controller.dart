// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sgemp_front_flutter/application/application.dart';

import '../../../shared/shared.dart';
import '../../ui.dart';

class NewUserPageController {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  TextEditingController textEditingControllerFirstName =
      TextEditingController();
  TextEditingController textEditingControllerLastName = TextEditingController();
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();
  TextEditingController textEditingControllerConfirmPassword =
      TextEditingController();

  bool isLoading = false;

  User loadedUser = User.empty();

  registerUser(
      {required GlobalKey<FormState> formKey,
      required BuildContext context}) async {
    if (formKey.currentState!.validate()) {
      loadedUser.firstname = textEditingControllerFirstName.text;
      loadedUser.lastname = textEditingControllerLastName.text;
      loadedUser.email = textEditingControllerEmail.text;
      loadedUser.password = textEditingControllerPassword.text;
      loadedUser.accountNonExpired = true;
      loadedUser.accountNonLocked = true;
      loadedUser.credentialsNonExpired = true;

      var result = await Provider.of<UserProvider>(context, listen: false)
          .registerUser(user: loadedUser);
      if (result['statusCode'] == 200) {
        loadedUser = User.empty();

        Navigator.of(context).pushReplacement(MaterialPageRoute<LoginPage>(
          builder: (BuildContext context) {
            return LoginPage();
          },
        ));
      } else if (result['statusCode'] != 200) {
        loadedUser = User.empty();
        SnackbarWidget.showSnackBar(context,
            text: result['body'].toString(),
            duration: EnvironmentConstants.snackBarDuration);
      }
    }
  }

  validateFirstName({required dynamic value}) {
    if (value == null || value.isEmpty) {
      return 'Por favor digite o nome';
    }
    return null;
  }

  validateLastName({required dynamic value}) {
    if (value == null || value.isEmpty) {
      return 'Por favor digite o sobrenome';
    }
    return null;
  }

  validateLastEmail({required dynamic value}) {
    if (value == null || value.isEmpty) {
      return 'Por favor digite o e-mail';
    }
    if (!value.toString().contains("@") || !value.toString().contains(".")) {
      return 'E-mail inválido';
    }
    return null;
  }

  validatePassword({required dynamic value}) {
    if (value == null || value.isEmpty) {
      return 'Por favor digite a senha';
    }
    if (value.toString().length < 6) {
      return 'Por favor digite uma senha com o mínimo de 6 caractéres';
    }
    return null;
  }

  validateConfirmPassword({required dynamic value}) {
    if (value == null || value.isEmpty) {
      return 'Por favor confirme a senha';
    }
    if (value.toString().length < 6) {
      return 'Por favor digite uma senha com o mínimo de 6 caractéres';
    }
    if (textEditingControllerPassword.text !=
        textEditingControllerConfirmPassword.text) {
      return 'A senhas não são iguais';
    }
    return null;
  }
}
