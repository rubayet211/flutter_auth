import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NoteProvider with ChangeNotifier {
  final CollectionReference notesCollection =
      FirebaseFirestore.instance.collection('notes');
  List<DocumentSnapshot> _notes = [];
  User? _user = FirebaseAuth.instance.currentUser;

  List<DocumentSnapshot> get notes => _notes;

  NoteProvider() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _user = user;
      if (_user != null) {
        _fetchNotes();
      }
    });
  }

  Future<void> _fetchNotes() async {
    if (_user != null) {
      final snapshot = await notesCollection
          .where('userId', isEqualTo: _user!.uid)
          .orderBy('timestamp', descending: true)
          .get();
      _notes = snapshot.docs;
      notifyListeners();
    }
  }

  Future<void> addNote(String note) async {
    if (_user != null) {
      await notesCollection.add({
        'note': note,
        'timestamp': Timestamp.now(),
        'userId': _user!.uid,
      });
      _fetchNotes();
    }
  }

  Future<String> getNoteById(String docId) async {
    try {
      DocumentSnapshot docSnapshot = await notesCollection.doc(docId).get();
      if (docSnapshot.exists) {
        return docSnapshot.get('note');
      } else {
        throw Exception('Document does not exist');
      }
    } catch (e) {
      throw Exception('Failed to get note');
    }
  }

  Future<void> updateNote(String docId, String newNote) async {
    await notesCollection.doc(docId).update({
      'note': newNote,
      'timestamp': Timestamp.now(),
    });
    _fetchNotes();
  }

  Future<void> deleteNoteById(String docId) async {
    await notesCollection.doc(docId).delete();
    _fetchNotes();
  }
}
