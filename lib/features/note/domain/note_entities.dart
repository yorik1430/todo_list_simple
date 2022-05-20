import '../../todo/domain/todo_entities.dart';

class Note {
  DateTime note_created = DateTime.now();
  String note_name = '';
  String note_description = '';
  ToDo? toDo;
}