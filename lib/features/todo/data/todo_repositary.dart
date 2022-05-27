import 'package:get_it/get_it.dart';
import '../domain/todo_entities.dart';
import 'todo_api.dart';

class ToDoModel {
  int? id;
  ToDo toDo = GetIt.instance<ToDo>();

  ToDoModel();
}

class ToDoListFetcher {
  static Future<List<ToDoModel>> FetchToDoes() {
    return DataApi.GetToDoes();
  }
}

class ToDoListSaver {
  ToDoModel noteModel;

  ToDoListSaver(this.noteModel);

  Future SaveToDo() async {
    await DataApi.SaveToDo(noteModel);
  }
}

