
import 'package:final_project/ui/pages/SignupPage.dart';
import 'package:final_project/ui/pages/chat.dart';
import 'package:final_project/ui/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'first',
      title: 'Chat App',
      routes: {
        'first': (context) => Scaffold(
              body: LoginPage(),
            ),
        'second': (context) => Scaffold(
              body: SignupPage(),
            ),
        'third': (context) => Scaffold(
              body: Chat(),
            )
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
