// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '/shared/shared.dart';
import '../../ui.dart';

class NewUser extends StatelessWidget {
  NewUser({super.key});

  NewUserPageController newUserPageController = NewUserPageController();

  @override
  Widget build(BuildContext context) {
    var screenSize = ScreenSize.getScreenSize(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro de usuário'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: screenSize.width * 0.8,
              child: Card(
                shape: const LinearBorder(),
                elevation: 30,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Wrap(
                    children: [
                      Wrap(
                        direction: Axis.vertical,
                        children: [
                          SizedBox(
                            width: 300,
                            child: TextFormField(
                              // validator: (value) =>
                              //     _homeController.validateEmail(value ?? ''),
                              //controller: _homeController.textEditingControllerEmail,
                              decoration: const InputDecoration(
                                hintText: 'E-mail',
                                label: Text("E-mail"),
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.email),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
