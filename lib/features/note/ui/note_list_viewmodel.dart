import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/note_repositary.dart';
import '../domain/note_usecases.dart';


abstract class NoteEvents {}

class NoteChange extends NoteEvents{
  NoteModel noteModel;

  NoteChange(this.noteModel);
}


class NotesReceive extends NoteEvents{}

class NoteDelete extends NoteEvents{}

abstract class NoteStates {}

class NotesEmpty extends NoteStates{}

class Notereceiving extends NoteStates {
  Notereceiving();
}

class Notereceived extends NoteStates {
  List<NoteModel> noteModels;

  Notereceived(this.noteModels);

}

class Noteerror extends NoteStates {}


class NoteBloc extends Bloc<NoteEvents,NoteStates> {
  NoteBloc(NoteStates initialState) : super(initialState);

  @override
  Stream<NoteStates> mapEventToState(NoteEvents event) async* {
    if (event is NoteChange) {

      await NoteSaver(event.noteModel).SaveNote();

    }

    if (event is NotesReceive || event is NoteChange) {
      yield Notereceiving();

      List<NoteModel> noteModels = await NoteListReceiver.ReceiveNotes();
      yield Notereceived(noteModels);

    }

  }
}