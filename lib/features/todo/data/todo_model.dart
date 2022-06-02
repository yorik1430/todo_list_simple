import '../domain/todo_entities.dart';

class ToDoModel extends ToDo{
  int? id;

  ToDoModel({todo_name = '', todo_description = '', date, isDone = false});
}