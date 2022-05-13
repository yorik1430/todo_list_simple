import '../data/data_repositary.dart';
import 'entities.dart';

class ToDoAdder {}

class ToDoDeleter {}

class ToDoSaver {}

class ToDoReader {}

class ToDoListReceiver {
  Future<List<ToDoNote>> ReceiveToDoes() async {
    return await ToDoListFetcher().FetchToDoes();
  }
}
