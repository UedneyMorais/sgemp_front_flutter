import 'package:flutter/material.dart';
import 'package:sgemp_front_flutter/shared/components/components.dart';

import '/ui/home/controller/home_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController _homeController = HomeController();
  @override
  Widget build(BuildContext context) {
    //var height = MediaQuery.of(context).size.height;
    //var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const AppBarWidget(),
      body: FutureBuilder(
        future: _homeController.loadInfo(context: context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('erro'),
            );
          } else {
            return const Center(
              child: Text('My Page!'),
            );
          }
        },
      ),
      drawer: const DrawerWidget(),
    );
  }
}
