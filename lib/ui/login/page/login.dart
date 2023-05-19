// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../../../shared/env/env.dart';
import '../../ui.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

LoginController _homeController = LoginController();

class _LoginState extends State<Login> {
  @override
  void initState() {
    setState(() {
      _homeController.startSettings();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = ScreenSize.getScreenSize(context);

    return Form(
      key: _homeController.formKey,
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
                                      _homeController.validateEmail(value),
                                  controller: _homeController
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
                                      _homeController.validatePassword(value),
                                  controller: _homeController
                                      .textEditingControllerPassword,
                                  obscureText:
                                      !_homeController.isPasswordVisible,
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
                                            _homeController.isPasswordVisible =
                                                !_homeController
                                                    .isPasswordVisible;
                                          });
                                        },
                                        child: !_homeController
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
                                        value: _homeController.rememberEmail,
                                        onChanged: (bool value) {
                                          setState(() {
                                            _homeController.rememberEmail =
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
                                      if (!_homeController.isLoading) {
                                        setState(() {
                                          _homeController.isLoading = true;
                                        });
                                        await _homeController.login(
                                            context: context);
                                        setState(() {
                                          _homeController.isLoading = false;
                                        });
                                      }
                                    },
                                    child: _homeController.isLoading
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
                                            _homeController.createNewUser(
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
