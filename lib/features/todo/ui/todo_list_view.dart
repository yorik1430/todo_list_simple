import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:date_field/date_field.dart';
import 'package:todo_list_simple/features/todo/ui/todo_list_viewmodel.dart';
import '../data/todo_model.dart';
import '../data/todo_repositary.dart';
import '../domain/todo_entities.dart';

final todoListProvider =
    StateNotifierProvider<ToDoBloc, List<ToDo>>((ref) {
  ToDoBloc toDoBloc = ToDoBloc([]);
  toDoBloc.ToDoesReceive();
  return toDoBloc;
});

class ToDoesPage extends ConsumerWidget {
  const ToDoesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Список задач'),
      ),
      body: Center(child: Consumer(builder: (BuildContext context, ref, _) {
        List<ToDo> toDoModels = ref.watch(todoListProvider);

        return ListView.builder(
            itemCount: toDoModels.length,
            itemBuilder: (cont, index) => ListTile(
                leading: Text(toDoModels[index].todo_date.toString()),
                title: Text(toDoModels[index].todo_name),
                trailing: Checkbox(
                  value: toDoModels[index].isDone,
                  onChanged: (_) {},
                ),
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => MyToDo(toDoModels[index])),
                    )));
      })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => MyToDo(ToDoModel())));
        },
        tooltip: 'Добавить задачу',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyToDo extends StatefulWidget {
  ToDo toDo;

  MyToDo(this.toDo);
  @override
  State<MyToDo> createState() {
    return MyToDoState(toDo);
  }
}

class MyToDoState extends State<MyToDo> {
  ToDo toDo;
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _descriptioncontroller = TextEditingController();

  MyToDoState(this.toDo);

  @override
  Widget build(BuildContext context) {
    _namecontroller.text = toDo.todo_name;
    _descriptioncontroller.text = toDo.todo_description;

    return Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: Center(
            child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    DateTimeField(
                      decoration:
                          const InputDecoration(hintText: 'Дата задачи'),
                      selectedDate: toDo.todo_date,
                      onDateSelected: (DateTime value) {
                        setState(() {
                          toDo.todo_date = value;
                        });
                      },
                    ),
                    Text('Название задачи'),
                    TextField(controller: _namecontroller),
                    Text('Описание задачи'),
                    TextField(controller: _descriptioncontroller),
                    Text('Задача выполнена'),
                    Checkbox(
                      value: toDo.isDone,
                      onChanged: (value) {
                        setState(() {
                          toDo.isDone = value ?? false;
                          toDo.todo_name = _namecontroller.text;
                          toDo.todo_description =
                              _descriptioncontroller.text;
                        });
                      },
                    ),
                    Consumer(builder: (BuildContext context, ref, _) {
                      return FloatingActionButton.extended(
                        onPressed: () {
                          toDo.todo_name = _namecontroller.text;
                          toDo.todo_description = _descriptioncontroller.text;

                          ToDoListSaver(toDo).SaveToDo().then((value) => ref.read(todoListProvider.notifier).ToDoesReceive());
                          Navigator.pop(context);
                        },
                        label: Text('Сохранить задачу'),
                        icon: Icon(Icons.add),
                        backgroundColor: Colors.amber,
                      );
                    })
                  ],
                ))));
  }
}
