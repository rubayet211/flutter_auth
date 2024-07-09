import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');

  Future<Object> createNote(String note) async {
    try {
      DocumentReference docRef = await notes.add({
        'note': note,
        'timestamp': Timestamp.now(),
      });
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to create note');
    }
  }

  Stream<QuerySnapshot> getNotes() {
    try {
      final notesStream =
          notes.orderBy('timestamp', descending: true).snapshots();
      return notesStream;
    } catch (e) {
      throw Exception('Failed to get notes stream');
    }
  }

  Future<String> getNoteById(String docId) async {
    try {
      DocumentSnapshot docSnapshot = await notes.doc(docId).get();
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
    try {
      await notes.doc(docId).update({
        'note': newNote,
        'timestamp': Timestamp.now(),
      });
    } catch (e) {
      throw Exception('Failed to update note');
    }
  }

  Future<void> deleteNoteById(String docId) async {
    try {
      await notes.doc(docId).delete();
    } catch (e) {
      throw Exception('Failed to delete note');
    }
  }
}
