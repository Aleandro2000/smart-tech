import 'package:flutter/material.dart';
import 'package:hard_and_soft_mobile/src/login/login.dart';
import 'package:hard_and_soft_mobile/src/register/register.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hard_and_soft_mobile/src/splashScreen/splashScreen.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
