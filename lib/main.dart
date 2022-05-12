// @dart=2.9

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/rendering.dart';
import 'package:hard_and_soft_mobile/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:hard_and_soft_mobile/src/login/login.dart';
import 'package:hard_and_soft_mobile/src/register/register.dart';
import 'package:hard_and_soft_mobile/src/splashScreen/splashScreen.dart';
import 'package:hard_and_soft_mobile/src/utils/security.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (await onCheckRealDevice(check)) {
    RendererBinding.instance.setSemanticsEnabled(true);
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Tech',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const Splash(),
      routes: {
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
      },
    );
  }
}
