
class ToDo {
  int? id;
  DateTime todo_date;
  String todo_name;
  String todo_description;
  bool isDone;

  ToDo({this.todo_name = '', this.todo_description = '', date, this.isDone = false}): todo_date = date ?? DateTime.now();

  }