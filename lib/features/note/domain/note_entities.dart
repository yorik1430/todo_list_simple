import '../../todo/domain/todo_entities.dart';

class Note {
  int? id;
  DateTime? note_created;
  String? note_name;
  String? note_description;
  int? toDoid;

  Note({this.note_name = '', this.note_description = '', created, this.toDoid}): note_created = created ?? DateTime.now();
}