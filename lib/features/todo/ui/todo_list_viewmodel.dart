import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/todo_repositary.dart';
import '../domain/todo_entities.dart';

class ToDoBloc extends StateNotifier<List<ToDo>> {
  ToDoBloc(List<ToDo> initialTodos) : super(initialTodos);

  void ToDoesReceive() async {

    state = await ToDoListFetcher().FetchToDoes();

    }

}