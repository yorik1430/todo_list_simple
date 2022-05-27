import '../data/note_repositary.dart';

class NoteDeleter {}

class NoteSaver {
  NoteModel noteModel;

  NoteSaver(this.noteModel);

  Future SaveNote() async {
    return await NoteListSaver(noteModel).SaveNote();
  }
}

class NoteListReceiver {
  static Future<List<NoteModel>> ReceiveNotes() {
    return NoteListFetcher.FetchNotes();
  }
}
