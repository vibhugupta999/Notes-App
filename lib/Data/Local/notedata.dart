// ignore_for_file: non_constant_identifier_names

class Note {
  final String? title;
  final String? description;
  final String descriptionJson;
  final int dateEdited;

  Note({
    required this.title,
    required this.description,
    required this.descriptionJson,
    required this.dateEdited,
  });

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      title: map["title"] as String?,
      description: map["description"] as String?,
      descriptionJson: map["descriptionJson"] as String? ?? "",
      dateEdited: map["date_edited"] as int? ?? 0,
    );
  }
}
