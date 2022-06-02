import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/todo_model.dart';
import '../data/todo_repositary.dart';

class ToDoBloc extends StateNotifier<List<ToDoModel>> {
  ToDoBloc(List<ToDoModel> initialTodos) : super(initialTodos);

  void ToDoesReceive() async {

    state = await ToDoListFetcher().FetchToDoes();

    }

}