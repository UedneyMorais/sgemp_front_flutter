// ignore_for_file: must_be_immutable, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import '/shared/shared.dart';
import '../../ui.dart';

class NewUser extends StatefulWidget {
  NewUser({Key? key}) : super(key: key);

  @override
  State<NewUser> createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final NewUserPageController _newUserPageController = NewUserPageController();

  @override
  Widget build(BuildContext context) {
    var screenSize = ScreenSize.getScreenSize(context);

    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro de usuários'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Align(
            alignment: Alignment.topCenter,
            child: LayoutBuilder(
              builder: (context, constraints) {
                double cardWidth = constraints.maxWidth * 0.9;

                return Card(
                  elevation: 30,
                  shape: const LinearBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Wrap(
                      runSpacing: 10,
                      children: [
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            SizedBox(
                              width: screenSize.width <= 660
                                  ? cardWidth
                                  : cardWidth / 3,
                              child: TextFormField(
                                controller: _newUserPageController
                                    .textEditingControllerFirstName,
                                validator: (value) => _newUserPageController
                                    .validateFirstName(value: value),
                                decoration: const InputDecoration(
                                  hintText: 'Nome',
                                  labelText: 'Nome',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width <= 660
                                  ? cardWidth
                                  : cardWidth / 3,
                              child: TextFormField(
                                controller: _newUserPageController
                                    .textEditingControllerLastName,
                                validator: (value) => _newUserPageController
                                    .validateLastName(value: value),
                                decoration: const InputDecoration(
                                  hintText: 'Sobrenome',
                                  labelText: 'Sobrenome',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width <= 660
                                  ? cardWidth
                                  : cardWidth / 3,
                              child: TextFormField(
                                controller: _newUserPageController
                                    .textEditingControllerEmail,
                                validator: (value) => _newUserPageController
                                    .validateLastEmail(value: value),
                                decoration: const InputDecoration(
                                  hintText: 'E-mail',
                                  labelText: 'E-mail',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Wrap(
                          direction: Axis.horizontal,
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            SizedBox(
                              width: screenSize.width <= 660
                                  ? cardWidth
                                  : cardWidth / 3,
                              child: TextFormField(
                                validator: (value) => _newUserPageController
                                    .validatePassword(value: value),
                                controller: _newUserPageController
                                    .textEditingControllerPassword,
                                obscureText:
                                    !_newUserPageController.isPasswordVisible,
                                decoration: InputDecoration(
                                  hintText: 'Senha',
                                  label: const Text("Senha"),
                                  border: const OutlineInputBorder(),
                                  suffixIcon: MouseRegion(
                                    cursor: MaterialStateMouseCursor.clickable,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _newUserPageController
                                                  .isPasswordVisible =
                                              !_newUserPageController
                                                  .isPasswordVisible;
                                        });
                                      },
                                      child: !_newUserPageController
                                              .isPasswordVisible
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: screenSize.width <= 660
                                  ? cardWidth
                                  : cardWidth / 3,
                              child: TextFormField(
                                validator: (value) => _newUserPageController
                                    .validateConfirmPassword(value: value),
                                controller: _newUserPageController
                                    .textEditingControllerConfirmPassword,
                                obscureText: !_newUserPageController
                                    .isConfirmPasswordVisible,
                                decoration: InputDecoration(
                                  hintText: 'Confirmar senha',
                                  label: const Text("Confirmar senha"),
                                  border: const OutlineInputBorder(),
                                  suffixIcon: MouseRegion(
                                    cursor: MaterialStateMouseCursor.clickable,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _newUserPageController
                                                  .isConfirmPasswordVisible =
                                              !_newUserPageController
                                                  .isConfirmPasswordVisible;
                                        });
                                      },
                                      child: !_newUserPageController
                                              .isConfirmPasswordVisible
                                          ? const Icon(Icons.visibility)
                                          : const Icon(Icons.visibility_off),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: cardWidth,
                          child: ElevatedButton(
                            style: const ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                Colors.blueAccent,
                              ),
                            ),
                            onPressed: () async {
                              if (!_newUserPageController.isLoading) {
                                setState(() {
                                  _newUserPageController.isLoading = true;
                                });
                                await _newUserPageController.registerUser(
                                    formKey: _formKey, context: context);
                                setState(() {
                                  _newUserPageController.isLoading = false;
                                });
                              }
                            },
                            child: _newUserPageController.isLoading
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
                                          screenSize.width <= 667 ? 14 : 12,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
