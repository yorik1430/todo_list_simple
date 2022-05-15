import '../data/data_repositary.dart';
import 'entities.dart';

class ToDoDeleter {}

class ToDoSaver {
  ToDoNoteModel noteModel;

  ToDoSaver(this.noteModel);

  Future SaveToDo() async {
    return await ToDoListSaver(noteModel).SaveToDo();
  }
}

class ToDoListReceiver {
  static Future<List<ToDoNoteModel>> ReceiveToDoes() {
    return ToDoListFetcher.FetchToDoes();
  }
}
