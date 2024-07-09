import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');

  Future<Object> createNote(String note) async {
    return notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getNotes() {
    final notesStream =
        notes.orderBy('timestamp', descending: true).snapshots();
    return notesStream;
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
      print('Error getting note: $e');
      throw Exception('Failed to get note');
    }
  }

  Future<void> updateNote(String docId, String newNote) {
    return notes.doc(docId).update({
      'note': newNote,
      'timestamp': Timestamp.now(),
    });
  }
}
