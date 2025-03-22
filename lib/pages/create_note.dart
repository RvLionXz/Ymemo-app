import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:ymemo_app/components/api_service.dart';

class NotePages extends StatefulWidget {
  const NotePages({super.key});

  @override
  State<NotePages> createState() => _NotePagesState();
}

class _NotePagesState extends State<NotePages> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  bool isButtonPress = false;

  void saveNote() async {
    if (isButtonPress) return;

    setState(() {
      isButtonPress = true;
    });

    final title = _titleController.text;
    final body = _contentController.text;

    if (title.isNotEmpty && body.isNotEmpty) {
      ApiService.createNotes(title, body).then((_) {
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
          setState(() {
            isButtonPress = false;
          });
        }
      });
      print("Title: $title, Content: $body");
    } else {
      print("Title or content cannot be empty");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Add Note",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blueAccent,
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Note Title",
                ),
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Expanded(
                child: TextField(
                  controller: _contentController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "your note",
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: isButtonPress ? null : saveNote,
          label: Text(
            isButtonPress ? "Saving.." : "Save Note",
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(Icons.save, color: Colors.white),
          backgroundColor: Colors.blueAccent,
        ),
      ),
    );
  }
}
