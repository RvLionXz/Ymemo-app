import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:ymemo_app/components/api_service.dart';
import 'package:ymemo_app/models/note_class.dart';

class EditPages extends StatefulWidget {
  final Note note;

  const EditPages({super.key, required this.note});

  @override
  State<EditPages> createState() => _EditPagesState();
}

class _EditPagesState extends State<EditPages> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  Note? note;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    note ??= ModalRoute.of(context)?.settings.arguments as Note?;
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
            "Edit Note",
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
          onPressed: () async {},
          label: Text("Save Note", style: TextStyle(color: Colors.white)),
          icon: Icon(Icons.save, color: Colors.white),
          backgroundColor: Colors.blueAccent,
        ),
      ),
    );
  }
}
