import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/todo_repositary.dart';
import '../domain/todo_usecases.dart';

abstract class ToDoEvents {}

class ToDoChange extends ToDoEvents{
  ToDoModel toDoModel;

  ToDoChange(this.toDoModel);
}

class ToDoesReceive extends ToDoEvents{}

class ToDoDelete extends ToDoEvents{}

abstract class ToDoStates {}

class ToDoesEmpty extends ToDoStates{}

class ToDoreceiving extends ToDoStates {
  ToDoreceiving();
}

class ToDoreceived extends ToDoStates {
  List<ToDoModel> toDoModels;

  ToDoreceived(this.toDoModels);

}

class ToDoerror extends ToDoStates {}


class ToDoBloc extends Bloc<ToDoEvents,ToDoStates> {
  ToDoBloc(ToDoStates initialState) : super(initialState);

  @override
  Stream<ToDoStates> mapEventToState(ToDoEvents event) async* {
    if (event is ToDoChange) {

      await ToDoSaver(event.toDoModel).SaveToDo();

    }

    if (event is ToDoesReceive || event is ToDoChange) {
      yield ToDoreceiving();

      List<ToDoModel> ToDoModels = await ToDoListReceiver.ReceiveToDoes();
      yield ToDoreceived(ToDoModels);

    }

  }
}