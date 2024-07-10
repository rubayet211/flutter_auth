import 'package:auth_demo/model/note_provider.dart';
import 'package:auth_demo/model/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _noteController = TextEditingController();

  void openNoteBox({String? docId}) async {
    final noteProvider = Provider.of<NoteProvider>(context, listen: false);
    if (docId != null) {
      final noteText = await noteProvider.getNoteById(docId);
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
                noteProvider.addNote(_noteController.text);
              } else {
                noteProvider.updateNote(docId, _noteController.text);
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
        actions: [
          IconButton(
            onPressed: () async {
              await Provider.of<UserProvider>(context, listen: false).signOut();
              Navigator.pushReplacementNamed(context, '/loginOrRegister');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openNoteBox,
        child: const Icon(Icons.add),
      ),
      body: Consumer<NoteProvider>(
        builder: (context, noteProvider, child) {
          if (noteProvider.notes.isEmpty) {
            return const Center(child: Text("No notes"));
          }

          return ListView.builder(
            itemCount: noteProvider.notes.length,
            itemBuilder: (context, index) {
              DocumentSnapshot note = noteProvider.notes[index];
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
                      onPressed: () => noteProvider.deleteNoteById(docId),
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
