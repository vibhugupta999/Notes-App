import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/Data/Local/notedata.dart';

import '../Services/database_services.dart';

class NoteProvider extends ChangeNotifier {
  List<Note> _notes = [];
  bool _isLoading = false;
  String? _currentUserId;
  StreamSubscription<User?>? _authStateSubscription;

  NoteProvider() {
    _listentoAuthStateChanges();
  }
  void setNotes() async {
    if(_currentUserId == null){
      _notes = [];
      notifyListeners();
      return;
    }
    _isLoading = true;
    notifyListeners();
    try {
      _notes = await DatabaseServices.getData(_currentUserId!);
    } catch (e) {
      _notes = [];
    }
    _isLoading = false;
    notifyListeners();
  }

  List<Note> get notes => [
    ...searchTerm.isEmpty ? _notes : _notes.where(_test),
  ];

  bool get isLoading => _isLoading;

  bool _test(Note note) {
    final term = _searchTerm.toLowerCase().trim();
    final title = note.title?.toLowerCase() ?? "";
    final desc = note.description?.toLowerCase() ?? "";
    return title.contains(term) || desc.contains(term);
  }

  void addNote(Note note) {
    if(_currentUserId == null) return;
    _isLoading = true;
    notifyListeners();
    _notes.add(note);
    DatabaseServices.addData(note: note,userId: _currentUserId!);
    _isLoading = false;
    notifyListeners();
  }

  void updateNote(Note note) {
    if(_currentUserId == null) return;
    _isLoading = true;
    notifyListeners();
    final index = _notes.indexWhere(
      (element) => element.dateEdited == note.dateEdited,
    );
    _notes[index] = note;
    DatabaseServices.updateData(userId: _currentUserId!,note: note);
    _isLoading = false;
    notifyListeners();
  }

  void deleteNote(Note note) {
    _notes.remove(note);
    DatabaseServices.deleteData(userId: _currentUserId!,dateEdited: note.dateEdited);
    notifyListeners();
  }

  String _searchTerm = "";

  set searchTerm(String value) {
    _searchTerm = value;
    notifyListeners();
  }

  String get searchTerm => _searchTerm;

  void _listentoAuthStateChanges() {
    _authStateSubscription = FirebaseAuth.instance.authStateChanges().listen((
      User? user,
    ) {
      if (user == null) {
        _currentUserId = null;
        _notes = [];
        _isLoading = false;
        notifyListeners();
      } else {
        if (_currentUserId != user.uid) {
          _currentUserId = user.uid;
          setNotes();
        }
      }
    });
  }

  @override
  void dispose() {
    _authStateSubscription?.cancel();
    super.dispose();
  }
}
