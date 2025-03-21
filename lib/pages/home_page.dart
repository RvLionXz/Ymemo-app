import 'dart:convert';

import 'package:flutter/material.dart';
import 'note_screen.dart';
import 'package:ymemo_app/components/api_service.dart';
import 'package:ymemo_app/models/note_class.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _homeScreen createState() => _homeScreen();
}

// ignore: camel_case_types
class _homeScreen extends State<HomeScreen> {
  List<Note> note = [];
  bool loading = true;

  void fetchNotes() async {
    loading = true;
    final result = await ApiService.getNotes();
    final finalResult = jsonEncode(result);
    final note = finalResult;
    print(note);
    loading = false;
  }

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 140,
                  width: double.infinity,
                  color: Colors.blueAccent,
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hello User",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  "Apa yang ingin anda tulis hari ini??",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              child: Icon(
                                Icons.info,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Search Notes",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: note.length,
                itemBuilder: (context, index) {
                  final item = note[index];
                  return ListTile(
                    title: Text(item.title ?? "Tanpa Judul"),
                    subtitle: Text(item.body ?? "Tanpa Isi"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
