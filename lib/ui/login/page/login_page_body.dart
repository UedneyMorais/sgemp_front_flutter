// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../shared/shared.dart';
import '../../ui.dart';

class LoginPageBody extends StatefulWidget {
  late LoginController loginController;
  LoginPageBody({super.key, required this.loginController});

  @override
  State<LoginPageBody> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenSize = ScreenSize.getScreenSize(context);

    return Form(
      key: _formKey,
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        autofocus: true,
        onKey: (event) async {
          if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
            _onSubmit();
          }
        },
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
                              : screenSize.width >= 667 &&
                                      screenSize.width < 1024
                                  ? screenSize.width * 0.6
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
                                    onEditingComplete: () {},
                                    validator: (value) => widget.loginController
                                        .validateEmail(value: value),
                                    controller: widget.loginController
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
                                    onEditingComplete: () {},
                                    validator: (value) => widget.loginController
                                        .validatePassword(value: value),
                                    controller: widget.loginController
                                        .textEditingControllerPassword,
                                    obscureText: !widget
                                        .loginController.isPasswordVisible,
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
                                              widget.loginController
                                                      .isPasswordVisible =
                                                  !widget.loginController
                                                      .isPasswordVisible;
                                            });
                                          },
                                          child: !widget.loginController
                                                  .isPasswordVisible
                                              ? const Icon(Icons.visibility)
                                              : const Icon(
                                                  Icons.visibility_off),
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
                                          value: widget
                                              .loginController.rememberEmail,
                                          onChanged: (bool value) {
                                            setState(() {
                                              widget.loginController
                                                  .rememberEmail = value;
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
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                          Colors.green[800],
                                        ),
                                      ),
                                      onPressed: () async {
                                        _onSubmit();
                                      },
                                      child: widget.loginController.isLoading
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
                                          cursor: MaterialStateMouseCursor
                                              .clickable,
                                          child: GestureDetector(
                                            onTap: () {
                                              widget.loginController
                                                  .createNewUser(
                                                      formKey: _formKey,
                                                      context: context);
                                            },
                                            child: const Text("Criar conta"),
                                          ),
                                        ),
                                        const Text(" | "),
                                        MouseRegion(
                                          cursor: MaterialStateMouseCursor
                                              .clickable,
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: const Text(
                                                "Esqueci minha senha"),
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
                              : screenSize.width >= 667 &&
                                      screenSize.width < 1024
                                  ? screenSize.width * 0.6
                                  : screenSize.width * 0.3,
                          child: Card(
                              color: Colors.green[800],
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
      ),
    );
  }

  _onSubmit() async {
    if (!widget.loginController.isLoading) {
      setState(() {
        widget.loginController.isLoading = true;
      });
      await widget.loginController.login(formKey: _formKey, context: context);
      setState(() {
        widget.loginController.isLoading = false;
      });
    }
  }
}
