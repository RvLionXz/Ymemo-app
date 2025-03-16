import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _homeScreen createState() => _homeScreen();
}

// ignore: camel_case_types
class _homeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("YMemo", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            //Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: "Search Notes",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                prefixIcon: Icon(Icons.search)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
