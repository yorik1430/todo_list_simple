import '../domain/note_usecases.dart';
import 'note_api.dart';
import 'note_model.dart';

class NoteListFetcher implements NoteListReceiver {
  Future<List<NoteModel>> ReceiveNotes() async {
    return await NoteApi.GetNotes();
  }
 }

class NoteListSaver implements NoteSaver {
  NoteModel note;
  NoteListSaver(this.note);

  Future SaveNote() async {
    await NoteApi.SaveNote(note);
  }

}

