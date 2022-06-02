import 'package:todo_list_simple/features/todo/data/todo_model.dart';
import '../domain/todo_usecases.dart';
import 'todo_api.dart';


class ToDoListFetcher implements ToDoListReceiver{
  Future<List<ToDoModel>> FetchToDoes() {
    return DataApi.GetToDoes();
  }
}

class ToDoListSaver implements ToDoSaver{
  ToDoModel noteModel;

  ToDoListSaver(this.noteModel);

  Future SaveToDo() async {
    await DataApi.SaveToDo(noteModel);
  }
}

