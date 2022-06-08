import '../domain/todo_entities.dart';

class ToDoModel extends ToDo{

  ToDoModel({todo_name = '', todo_description = '', date, isDone = false}):super(todo_name:todo_name, todo_description:todo_description, date:date, isDone:isDone);
}