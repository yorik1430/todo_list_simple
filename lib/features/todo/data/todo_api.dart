import '../domain/todo_entities.dart';
import 'todo_repositary.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DataApi {
  static Future SaveToDo(ToDoModel noteModel) async {
    final box = await Hive.openBox('ToDoes2');
    if (noteModel.id == null) {
      int id = await box.add('');
      noteModel.id = id;
    }
    final valueToDo = ToDoToMap(noteModel);
    await box.put(noteModel.id, valueToDo);
  }

  static Future<List<ToDoModel>> GetToDoes() async {
    final box = await Hive.openBox('ToDoes2');
    final res = await box.values;
    List<ToDoModel> noteModels = res.isNotEmpty ? res.map((element) => ToDoFromMap(element)).toList() : [];

    return noteModels;
  }

  static Map<String, dynamic> ToDoToMap(ToDoModel noteModel) {
    return {'id':noteModel.id,
      'todo_date':noteModel.toDo.todo_date,
      'todo_name':noteModel.toDo.todo_name,
      'todo_description':noteModel.toDo.todo_description,
      'isDone':noteModel.toDo.isDone};
  }

  static ToDoModel ToDoFromMap(mapnoteModel) {
    ToDo note = ToDo();
    note.todo_date = mapnoteModel['todo_date'];
    note.todo_name = mapnoteModel['todo_name'];
    note.todo_description = mapnoteModel['todo_description'];
    note.isDone = mapnoteModel['isDone'];

    ToDoModel noteModel = ToDoModel(note);
    noteModel.id = mapnoteModel['id'];

    return noteModel;
  }
}