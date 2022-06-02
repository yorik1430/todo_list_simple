import '../domain/note_entities.dart';

class NoteModel extends Note {
  int? id;

  NoteModel({note_name, note_description, note_created, toDo});
}
