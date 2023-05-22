import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../application/application.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

late User loggedUser;

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  void initState() {
    loggedUser = Provider.of<UserProvider>(context, listen: false).loggedUser;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green[500],
            ),
            child: CircleAvatar(
              backgroundColor: Colors.green[200],
              child: Text(
                loggedUser.firstname[0] + loggedUser.lastname[0],
                style: const TextStyle(fontSize: 44, color: Colors.white),
              ),
            ),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
