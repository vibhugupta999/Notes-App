import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notes/Data/Local/notedata.dart';
import 'package:notes/Provider/noteprovider.dart';
import 'package:provider/provider.dart';

class Notecontrollerprovider extends ChangeNotifier {
  bool _readOnly = false;
  set readOnly(bool value) {
    _readOnly = value;
    notifyListeners();
  }

  bool get readOnly => _readOnly;

  Note? _note;

  set note(Note? value) {
    _note = value;
    _title = _note!.title ?? "";
    _desc = Document.fromJson(jsonDecode(_note!.descriptionJson));
    notifyListeners();
  }

  Note? get note => _note;

  String _title = "";

  set title(String value) {
    _title = value;
    notifyListeners();
  }

  String get title => _title.trim();

  Document _desc = Document();

  set desc(Document value) {
    _desc = value;
    notifyListeners();
  }

  Document get desc => _desc;

  bool get isNewNote => _note == null;

  bool get canSaveNote {
    final String? finaltitle = title.isNotEmpty ? title : null;
    final String? finaldesc = desc.toPlainText().trim().isNotEmpty
        ? desc.toPlainText().trim()
        : null;
    bool canSave = finaltitle != null || finaldesc != null;
    if (!isNewNote) {
      final finaldescJson = jsonEncode(desc.toDelta().toJson());
      canSave &= finaltitle != note!.title || finaldescJson != note!.descriptionJson;
    }
    return canSave;
  }

  void saveNote(BuildContext context) {
    final String? finaltitle = title.isNotEmpty ? title : null;
    final String? finaldesc = desc.toPlainText().toString().isNotEmpty
        ? desc.toPlainText().toString()
        : null;
    final String finaldescJson = jsonEncode(_desc.toDelta().toJson());
    final int finaldate = DateTime.now().millisecondsSinceEpoch;
    final Note note = Note(
      title: finaltitle,
      description: finaldesc,
      descriptionJson: finaldescJson,
      dateEdited: isNewNote ? finaldate : _note!.dateEdited,
    );

    final noteProvider = context.read<NoteProvider>();
    isNewNote ? noteProvider.addNote(note) : noteProvider.updateNote(note);
  }
}
