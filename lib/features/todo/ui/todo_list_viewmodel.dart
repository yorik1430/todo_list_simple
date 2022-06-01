import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/todo_repositary.dart';
import '../domain/todo_usecases.dart';

class ToDoBloc extends StateNotifier<List<ToDoModel>> {
  ToDoBloc(List<ToDoModel> initialTodos) : super(initialTodos);

  void ToDoesReceive() async {

    state = await ToDoListReceiver.ReceiveToDoes();

    }

}