import 'package:flutter/material.dart';
import 'package:ymemo_app/pages/home_page.dart';
import 'package:ymemo_app/pages/note_screen.dart';
import 'pages/login_screen.dart';
import 'pages/register_screen.dart';
import 'pages/note_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/note': (context) => NoteScreen()
      },
    );
  }
}
