import 'package:flutter/material.dart';
import 'package:ymemo_app/pages/about.dart';
import 'create_note.dart';
import 'package:ymemo_app/components/api_service.dart';
import 'package:ymemo_app/models/note_class.dart';
import 'edit_note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _homeScreen createState() => _homeScreen();
}

// ignore: camel_case_types
class _homeScreen extends State<HomeScreen> {
  List<Note> note = [];
  bool loading = true;
  String username = "";

  void fetchNotes() async {
    setState(() {
      loading = true;
    });

    final result = await ApiService.getNotes();

    setState(() {
      note = result;
      loading = false;
    });
  }

  void getUsername() async {
    final userdata = await UserData.getUserData();
    setState(() {
      username = userdata ?? "Guest";
    });
  }

  @override
  void initState() {
    super.initState();
    fetchNotes();
    getUsername();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 80,
                    width: double.infinity,
                    color: Colors.blueAccent,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Hello $username",
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
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => const aboutPages(),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.info,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: 50,
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
              loading
                  ? Expanded(
                    child: Container(
                      color: Colors.white,
                      child: const Center(
                        child: CircularProgressIndicator(color: Colors.blue),
                      ),
                    ),
                  )
                  : Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: ListView.builder(
                          itemCount: note.length,
                          itemBuilder: (context, index) {
                            final item = note[index];
                            return Card(
                              clipBehavior: Clip.hardEdge,
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => EditPages(note: item),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title: Text(
                                    item.title ?? 'Tanpa Judul',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    item.body ?? 'Tanpa Isi',
                                    maxLines: 2,
                                  ),
                                  trailing: IconButton(
                                    onPressed: () async {
                                      await ApiService.deleteNotes(item.id!);
                                      fetchNotes();
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotePages()),
            );
          },
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}
