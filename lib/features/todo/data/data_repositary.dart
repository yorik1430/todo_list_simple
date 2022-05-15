import '../domain/entities.dart';
import 'data_api.dart';

class ToDoNoteModel {
  int? id;
  ToDoNote note;

  ToDoNoteModel(this.note);
}

class ToDoListFetcher {
  static Future<List<ToDoNoteModel>> FetchToDoes() {
    return DataApi.GetToDoes();
  }
}

class ToDoListSaver {
  ToDoNoteModel noteModel;

  ToDoListSaver(this.noteModel);

  Future SaveToDo() async {
    await DataApi.SaveToDo(noteModel);
  }
}

