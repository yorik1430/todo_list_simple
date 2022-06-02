import 'package:todo_list_simple/features/todo/data/todo_model.dart';
import '../domain/todo_entities.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DataApi {
  static Future SaveToDo(ToDoModel noteModel) async {
    final box = await Hive.openBox('ToDoes02');
    if (noteModel.id == null) {
      int id = await box.add('');
      noteModel.id = id;
    }
    final valueToDo = ToDoToMap(noteModel);
    await box.put(noteModel.id, valueToDo);
  }

  static Future<List<ToDoModel>> GetToDoes() async {
    final box = await Hive.openBox('ToDoes02');
    final res = await box.values;
    List<ToDoModel> noteModels = res.isNotEmpty ? res.map((element) => ToDoFromMap(element)).toList() : [];

    return noteModels;
  }

  static Map<String, dynamic> ToDoToMap(ToDoModel noteModel) {
    return {'id':noteModel.id,
      'todo_date':noteModel.todo_date,
      'todo_name':noteModel.todo_name,
      'todo_description':noteModel.todo_description,
      'isDone':noteModel.isDone};
  }

  static ToDoModel ToDoFromMap(mapnoteModel) {

    ToDoModel todoModel = ToDoModel(todo_name: mapnoteModel['todo_name'],todo_description: mapnoteModel['todo_description'], date: mapnoteModel['todo_date'],isDone: mapnoteModel['isDone']);
    todoModel.id = mapnoteModel['id'];

    return todoModel;
  }
}