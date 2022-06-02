import '../data/todo_repositary.dart';
import 'todo_entities.dart';

class ToDoDeleter {}

abstract class ToDoSaver {
  SaveToDo();
}

abstract class ToDoListReceiver {
  FetchToDoes();
}
