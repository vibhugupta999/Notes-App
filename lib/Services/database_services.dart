import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes/Data/Local/notedata.dart';

class DatabaseServices {
  DatabaseServices._();

  static User? get user => FirebaseAuth.instance.currentUser;

  static final _firestore = FirebaseFirestore.instance;

  static void addData({required String userId, required Note note}) async {
    if (userId.isEmpty) {
      return;
    }
    final docRef = _firestore.collection("Users").doc(userId);
    final snap = await docRef.get();
    if (!snap.exists) {
      docRef.set({
        "notes": [
          {
            "title": note.title,
            "description": note.description,
            "descriptionJson": note.descriptionJson,
            "date_edited": note.dateEdited,
          },
        ],
      });
    } else {
      docRef.update({
        "notes": FieldValue.arrayUnion([
          {
            "title": note.title,
            "description": note.description,
            "descriptionJson": note.descriptionJson,
            "date_edited": note.dateEdited,
          },
        ]),
      });
    }
  }

  static Future<void> deleteData({
    required String userId,
    required final dateEdited,
  }) async {
    if (userId.isEmpty) {
      return;
    }
    final docRef = _firestore.collection("Users").doc(userId);
    final snap = await docRef.get();
    List notesList = List.from(snap.data()?["notes"] ?? []);
    notesList.removeWhere((element) => element["date_edited"] == dateEdited);
    docRef.update({"notes": notesList});
  }

  static void updateData({required String userId, required Note note}) async {
    if (userId.isEmpty) {
      return;
    }
    final docRef = _firestore.collection("Users").doc(userId);
    final snap = await docRef.get();
    List notesList = List.from(snap.data()?["notes"] ?? []);
    final idx = notesList.indexWhere(
      (element) => element["date_edited"] == note.dateEdited,
    );
    if (idx != -1) {
      notesList[idx]["title"] = note.title;
      notesList[idx]["description"] = note.description;
      notesList[idx]["descriptionJson"] = note.descriptionJson;
    }
    docRef.update({"notes": notesList});
  }

  static Future<List<Note>> getData(String userId) async {
    if (userId.isEmpty) {
      return [];
    }
    final snap = await _firestore.collection("Users").doc(userId).get();
    if (!snap.exists || snap.data() == null) {
      return [];
    }
    List<dynamic> noteList = snap.data()?["notes"] ?? [];
    List<Note> notes = noteList
        .map((e) => Note.fromMap(Map<String, dynamic>.from(e)))
        .toList();
    return notes;
  }
}
