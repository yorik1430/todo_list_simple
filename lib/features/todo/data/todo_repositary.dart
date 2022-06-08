import '../domain/todo_entities.dart';
import '../domain/todo_usecases.dart';
import 'todo_api.dart';

class ToDoListFetcher implements ToDoListReceiver{
  Future<List<ToDo>> FetchToDoes() {
    return DataApi.GetToDoes();
  }
}

class ToDoListSaver implements ToDoSaver{
  ToDo toDo;

  ToDoListSaver(this.toDo);

  Future SaveToDo() async {
    await DataApi.SaveToDo(toDo);
  }
}

