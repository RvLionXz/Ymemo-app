import 'package:flutter/material.dart';
import 'package:ymemo_app/pages/note_screen.dart';
import 'pages/login_screen.dart';
import 'pages/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/note': (context) => NoteScreen()
      },
    );
  }
}
