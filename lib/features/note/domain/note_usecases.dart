import 'note_entities.dart';

class NoteDeleter {}

abstract class NoteSaver {
  SaveNote();
}

abstract class NoteListReceiver {
  ReceiveNotes();
}
