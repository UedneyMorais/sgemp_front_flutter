// ignore_for_file: use_build_context_synchronously, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import '../../../shared/env/env.dart';
import '../../ui.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final LoginController _loginController = LoginController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    setState(() {
      _loginController.startSettings();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = ScreenSize.getScreenSize(context);

    return Form(
      key: _formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(top: screenSize.height * 0.15),
              child: Column(
                children: [
                  Stack(
                    fit: StackFit.loose,
                    children: [
                      SizedBox(
                        width: screenSize.width <= 667
                            ? screenSize.width * 0.9
                            : screenSize.width * 0.3,
                        child: Card(
                          shape: const LinearBorder(),
                          elevation: 30,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: screenSize.height * 0.10,
                                left: screenSize.width * 0.02,
                                right: screenSize.width * 0.02,
                                bottom: screenSize.height * 0.10),
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (value) =>
                                      _loginController.validateEmail(value),
                                  controller: _loginController
                                      .textEditingControllerEmail,
                                  decoration: const InputDecoration(
                                    hintText: 'E-mail',
                                    label: Text("E-mail"),
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.email),
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                TextFormField(
                                  validator: (value) =>
                                      _loginController.validatePassword(value),
                                  controller: _loginController
                                      .textEditingControllerPassword,
                                  obscureText:
                                      !_loginController.isPasswordVisible,
                                  decoration: InputDecoration(
                                    hintText: 'Senha',
                                    label: const Text("Senha"),
                                    border: const OutlineInputBorder(),
                                    prefixIcon: const Icon(Icons.password),
                                    suffixIcon: MouseRegion(
                                      cursor:
                                          MaterialStateMouseCursor.clickable,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _loginController.isPasswordVisible =
                                                !_loginController
                                                    .isPasswordVisible;
                                          });
                                        },
                                        child: !_loginController
                                                .isPasswordVisible
                                            ? const Icon(Icons.visibility)
                                            : const Icon(Icons.visibility_off),
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Wrap(
                                    children: [
                                      SwitchListTile(
                                        title: const Text('Lembrar e-mail'),
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        value: _loginController.rememberEmail,
                                        onChanged: (bool value) {
                                          setState(() {
                                            _loginController.rememberEmail =
                                                value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                        Colors.blueAccent,
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (!_loginController.isLoading) {
                                        setState(() {
                                          _loginController.isLoading = true;
                                        });
                                        await _loginController.login(
                                            context: context);
                                        setState(() {
                                          _loginController.isLoading = false;
                                        });
                                      }
                                    },
                                    child: _loginController.isLoading
                                        ? const SizedBox(
                                            height: 15,
                                            width: 15,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          )
                                        : Text(
                                            "ENTRAR",
                                            style: TextStyle(
                                                fontSize:
                                                    screenSize.width <= 667
                                                        ? 14
                                                        : 12),
                                          ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize.width * 0.03,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Wrap(
                                    children: [
                                      MouseRegion(
                                        cursor:
                                            MaterialStateMouseCursor.clickable,
                                        child: GestureDetector(
                                          onTap: () {
                                            _loginController.createNewUser(
                                                formKey: _formKey,
                                                context: context);
                                          },
                                          child: const Text("Criar conta"),
                                        ),
                                      ),
                                      const Text(" | "),
                                      MouseRegion(
                                        cursor:
                                            MaterialStateMouseCursor.clickable,
                                        child: GestureDetector(
                                          onTap: () {},
                                          child:
                                              const Text("Esqueci minha senha"),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenSize.width <= 667
                            ? screenSize.width * 0.9
                            : screenSize.width * 0.3,
                        child: Card(
                            color: Colors.blueAccent,
                            shape: const LinearBorder(),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: screenSize.height * 0.02,
                                  bottom: screenSize.height * 0.02),
                              child: const Center(child: Text("SISTEMA TAL")),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
