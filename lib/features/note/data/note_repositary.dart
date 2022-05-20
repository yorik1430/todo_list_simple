import '../domain/note_entities.dart';
import 'note_api.dart';

class NoteModel {
  int? id;
  Note note;

  NoteModel(this.note);
}

class NoteListFetcher {
  static Future<List<NoteModel>> FetchToDoes() {
    return NoteApi.GetToDoes();
  }
}

class NoteListSaver {
  NoteModel noteModel;

  NoteListSaver(this.noteModel);

  Future SaveNote() async {
    await NoteApi.SaveToDo(noteModel);
  }
}

