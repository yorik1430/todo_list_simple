import '../domain/note_entities.dart';

class NoteModel extends Note {

  NoteModel({String? name, String? description, DateTime? created, int? toDoid}):super(note_name:name, note_description:description, created:created, toDoid:toDoid);
}
