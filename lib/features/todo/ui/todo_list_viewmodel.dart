import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/data_repositary.dart';
import '../domain/entities.dart';
import '../domain/use_cases.dart';

abstract class NoteEvents {}

class NoteChange extends NoteEvents{
  ToDoNoteModel noteModel;

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
  List<ToDoNoteModel> noteModels;

  Notereceived(this.noteModels);

}

class Noteerror extends NoteStates {}


class ToDoBloc extends Bloc<NoteEvents,NoteStates> {
  ToDoBloc(NoteStates initialState) : super(initialState);

  @override
  Stream<NoteStates> mapEventToState(NoteEvents event) async* {
    if (event is NoteChange) {

      await ToDoSaver(event.noteModel).SaveToDo();

    }

    if (event is NotesReceive || event is NoteChange) {
      yield Notereceiving();

      List<ToDoNoteModel> noteModels = await ToDoListReceiver.ReceiveToDoes();
      yield Notereceived(noteModels);

    }

  }
}