import 'package:flutter/material.dart';
import 'package:ymemo_app/pages/about.dart';
import 'create_note.dart';
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
    setState(() {
      loading = true;
    });

    final result = await ApiService.getNotes();

    setState(() {
      note = result;
      loading = false;
    });
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
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const aboutPages()));
                                },
                                child: Icon(Icons.info, color: Colors.white, size: 30,),
                              )
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
            loading
                ? const Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                )
                : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.builder(
                      itemCount: note.length,
                      itemBuilder: (context, index) {
                        final item = note[index];
                        return Card(
                          clipBehavior: Clip.hardEdge,
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () {
                              debugPrint("Card Tap");
                            },
                            child: ListTile(
                              title: Text(
                                item.title ?? 'Tanpa Judul',
                                style: TextStyle(fontWeight: FontWeight.bold),
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
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
