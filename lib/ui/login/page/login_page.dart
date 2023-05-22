// ignore_for_file: use_build_context_synchronously, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

import '../../ui.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController loginController = LoginController();

  @override
  void initState() {
    setState(() {
      loginController.startSettings();
      // _loginController.textEditingControllerEmail.text =
      //     "uedneymorais@gmail.com";
      // _loginController.textEditingControllerPassword.text = "123456";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoginPageBody(loginController: loginController);
  }
}
