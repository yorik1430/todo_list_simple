import '../data/todo_repositary.dart';
import 'todo_entities.dart';

class ToDoDeleter {}

class ToDoSaver {
  ToDoModel noteModel;

  ToDoSaver(this.noteModel);

  Future SaveToDo() async {
    return await ToDoListSaver(noteModel).SaveToDo();
  }
}

class ToDoListReceiver {
  static Future<List<ToDoModel>> ReceiveToDoes() {
    return ToDoListFetcher.FetchToDoes();
  }
}
