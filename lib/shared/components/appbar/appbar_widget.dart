import 'package:flutter/material.dart';

import '../../shared.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final appBarWidgetController = AppBarWidgetController();
    return AppBar(
      title: const Text("SISTEMA TAL"),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15),
          child: GestureDetector(
            onTap: () {
              appBarWidgetController.logoff(context: context);
            },
            child: const Icon(Icons.exit_to_app),
          ),
        ),
      ],
    );
  }
}
