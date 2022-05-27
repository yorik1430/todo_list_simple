import 'package:get_it/get_it.dart';
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

    ToDoModel todoModel = GetIt.instance<ToDoModel>();
    todoModel.id = mapnoteModel['id'];
    todoModel.toDo.todo_date = mapnoteModel['todo_date'];
    todoModel.toDo.todo_name = mapnoteModel['todo_name'];
    todoModel.toDo.todo_description = mapnoteModel['todo_description'];
    todoModel.toDo.isDone = mapnoteModel['isDone'];

    return todoModel;
  }
}