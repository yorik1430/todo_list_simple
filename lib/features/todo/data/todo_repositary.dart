import '../domain/todo_entities.dart';
import 'todo_api.dart';

class ToDoModel {
  int? id;
  ToDo toDo;

  ToDoModel(this.toDo);
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

