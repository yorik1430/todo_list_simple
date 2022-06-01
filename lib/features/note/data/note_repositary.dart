import '../domain/note_entities.dart';
import 'note_api.dart';

class NoteModel {
  int? id;
  Note note;

  NoteModel(this.note);
}

class NoteListFetcher {
  static Future<List<NoteModel>> FetchNotes() {
    return NoteApi.GetNotes();
  }
}

class NoteListSaver {
  NoteModel noteModel;

  NoteListSaver(this.noteModel);

  Future SaveNote() async {
    await NoteApi.SaveNote(noteModel);
  }
}

