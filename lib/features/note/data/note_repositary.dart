import 'package:get_it/get_it.dart';
import '../domain/note_entities.dart';
import 'note_api.dart';

class NoteModel {
  int? id;
  Note note = GetIt.instance<Note>();

  NoteModel();
}

class NoteListFetcher {
  static Future<List<NoteModel>> FetchNotes() {
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

