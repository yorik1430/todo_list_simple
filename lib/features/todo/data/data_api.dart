import '../domain/entities.dart';
import 'data_repositary.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DataApi {
  static Future SaveToDo(ToDoNoteModel noteModel) async {
    final box = await Hive.openBox('ToDoes2');
    if (noteModel.id == null) {
      int id = await box.add('');
      noteModel.id = id;
    }
    final valueToDo = ToDoToMap(noteModel);
    await box.put(noteModel.id, valueToDo);
  }

  static Future<List<ToDoNoteModel>> GetToDoes() async {
    final box = await Hive.openBox('ToDoes2');
    final res = await box.values;
    List<ToDoNoteModel> noteModels = res.isNotEmpty ? res.map((element) => ToDoFromMap(element)).toList() : [];

    return noteModels;
  }

  static Map<String, dynamic> ToDoToMap(ToDoNoteModel noteModel) {
    return {'id':noteModel.id,
      'todo_date':noteModel.note.todo_date,
      'todo_name':noteModel.note.todo_name,
      'todo_description':noteModel.note.todo_description,
      'isDone':noteModel.note.isDone};
  }

  static ToDoNoteModel ToDoFromMap(Map<String, dynamic> mapnoteModel) {
    ToDoNote note = ToDoNote();
    note.todo_date = mapnoteModel['todo_date'];
    note.todo_name = mapnoteModel['todo_name'];
    note.todo_description = mapnoteModel['todo_description'];
    note.isDone = mapnoteModel['isDone'];

    ToDoNoteModel noteModel = ToDoNoteModel(note);
    noteModel.id = mapnoteModel['id'];

    return noteModel;
  }
}