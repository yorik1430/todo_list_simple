import 'package:flutter_bloc/flutter_bloc.dart';
import '../domain/entities.dart';
import '../domain/use_cases.dart';

enum Events {receive, add, delete}

abstract class NoteStates {}

class Notereceiving extends NoteStates {}

class Notereceived extends NoteStates {
  List<ToDoNote> notes;

  Notereceived(this.notes);

}

class Noteerror extends NoteStates {}


class ToDoBloc extends Bloc {
  ToDoBloc(initialState) : super(initialState);

  @override
  Stream<NoteStates> mapEventToState(Events event) async* {
    if (event == Events.receive) {
      yield Notereceiving();

      List<ToDoNote> notes = await ToDoListReceiver().ReceiveToDoes();
      yield Notereceived(notes);

    }
  }
}