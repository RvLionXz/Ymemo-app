import 'package:flutter/material.dart';

class aboutPages extends StatefulWidget {
  const aboutPages({super.key});

  @override
  State<aboutPages> createState() => _aboutPagesState();
}

class _aboutPagesState extends State<aboutPages> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                "Hello World",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
