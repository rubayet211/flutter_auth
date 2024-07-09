import 'package:auth_demo/services/firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _noteController = TextEditingController();
  final FirestoreService firestoreService = FirestoreService();
  void openNoteBox({String? docId}) async {
    if (docId != null) {
      final noteText = await firestoreService.getNoteById(docId);
      _noteController.text = noteText;
    } else {
      _noteController.clear();
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: _noteController,
          decoration: InputDecoration(
            hintText: docId == null ? 'Enter your note' : 'Edit your note',
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (docId == null) {
                firestoreService.createNote(_noteController.text);
              } else {
                firestoreService.updateNote(docId, _noteController.text);
              }

              _noteController.clear();

              Navigator.pop(context);
            },
            child: docId == null ? const Text("Add") : const Text("Update"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getNotes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List notesList = snapshot.data!.docs;

            return ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context, index) {
                DocumentSnapshot note = notesList[index];
                String docId = note.id;

                Map<String, dynamic> data = note.data() as Map<String, dynamic>;
                String noteText = data['note'];

                return ListTile(
                  title: Text(noteText),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => openNoteBox(docId: docId),
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () => firestoreService.deleteNoteById(docId),
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return const Text("No notes");
          }
        },
      ),
    );
  }
}
