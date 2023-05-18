import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sgemp_front_flutter/shared/env/env.dart';

import 'application/application.dart';
import 'ui/ui.dart';

class SgempApp extends StatelessWidget {
  const SgempApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    Endpoints endpoints = Endpoints();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => AuthorityProvider(endpoints: endpoints)),
        ChangeNotifierProxyProvider<AuthorityProvider, UserProvider>(
          create: (_) => UserProvider(token: '', endpoints: endpoints),
          update: (context, authority, previous) =>
              UserProvider(token: authority.token, endpoints: endpoints),
        ),
      ],
      child: MaterialApp(
        title: 'Sistema de gerenciamento de empresas',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
          useMaterial3: false,
        ),
        home: const Login(),
      ),
    );
  }
}
