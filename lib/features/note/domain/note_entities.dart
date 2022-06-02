import '../../todo/domain/todo_entities.dart';

class Note {
  DateTime? note_created;
  String note_name;
  String note_description;
  ToDo? toDo;

  Note({this.note_name = '', this.note_description = '', created, this.toDo}): note_created = created ?? DateTime.now();
}