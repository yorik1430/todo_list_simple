import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/note_repositary.dart';
import '../domain/note_usecases.dart';

class NoteBloc extends StateNotifier<List<NoteModel>> {
  NoteBloc(List<NoteModel> initialState) : super(initialState);

  void NotesReceive() async {
      state = await NoteListReceiver.ReceiveNotes();
    }

}