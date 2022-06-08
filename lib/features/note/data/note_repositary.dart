import '../domain/note_entities.dart';
import '../domain/note_usecases.dart';
import 'note_api.dart';

class NoteListFetcher implements NoteListReceiver {
  Future<List<Note>> ReceiveNotes() async {
    return await NoteApi.GetNotes();
  }
 }

class NoteListSaver implements NoteSaver {
  Note note;
  NoteListSaver(this.note);

  Future SaveNote() async {
    await NoteApi.SaveNote(note);
  }

}

