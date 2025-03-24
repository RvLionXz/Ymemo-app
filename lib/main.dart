import 'package:flutter/material.dart';
import 'package:ymemo_app/pages/home_page.dart';
import 'package:ymemo_app/pages/note_screen.dart';
import 'pages/login_screen.dart';
import 'pages/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = (prefs.getBool('isLoggedIn') ?? false);


  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn ;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? HomeScreen() : LoginScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/note': (context) => NoteScreen(),
      },
    );
  }
}
