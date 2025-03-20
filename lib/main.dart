import 'package:flutter/material.dart';
import 'package:ymemo_app/components/home_page.dart';
import 'package:ymemo_app/components/note_screen.dart';
import 'components/login_screen.dart';
import 'components/register_screen.dart';
import 'components/note_screen.dart';

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
