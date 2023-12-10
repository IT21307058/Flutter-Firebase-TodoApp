import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_web_app/Service/Auth_Service.dart';
import 'package:firebase_web_app/pages/AddTodo.dart';
import 'package:firebase_web_app/pages/HomePage.dart';
import 'package:firebase_web_app/pages/SignUpPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_web_app/pages/SignInPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthClass authClass = AuthClass();
  Widget currentPage = SignUpPage();

  @override
  void initState() {
    super.initState();
    // authClass.signOut();
    checkLogin();
  }

  void checkLogin() async {
    String? token = await authClass.getToken();
    print("token: $token");
    if (token != null)
      setState(() {
        currentPage = HomePage();
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AddTodoPage(),
    );
  }
}
