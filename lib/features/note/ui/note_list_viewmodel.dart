import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/note_model.dart';
import '../data/note_repositary.dart';
import '../domain/note_entities.dart';

class NoteBloc extends StateNotifier<List<Note>> {
  NoteBloc(List<Note> initialState) : super(initialState);

  void NotesReceive() async {
      state = await NoteListFetcher().ReceiveNotes();
    }

}