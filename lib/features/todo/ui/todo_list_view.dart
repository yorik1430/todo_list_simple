import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:date_field/date_field.dart';
import 'package:todo_list_simple/features/todo/ui/todo_list_viewmodel.dart';
import '../data/data_repositary.dart';
import '../domain/entities.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(''),
      ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: BlocBuilder<ToDoBloc, NoteStates>(
              builder: (BuildContext context, state) {
        if (state is NotesEmpty) {
          BlocProvider.of<ToDoBloc>(context).add(NotesReceive());
          return Text('данные начинают считыватся');
        }
        if (state is Notereceived) {
          return ListView.builder(
            itemCount: state.noteModels.length,
              itemBuilder: (cont, index) => ListTile(
                    title: Text(state.noteModels[index].note.todo_name),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => MyToDo(state.noteModels[index])),
                  )));
        }
        if (state is Notereceiving) {
          return Text('данные считываются');
        }
        return Text('ошибка');
      })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => MyToDo(ToDoNoteModel(ToDoNote()))));
        },
        tooltip: 'Добавить дело',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyToDo extends StatefulWidget {
  ToDoNoteModel noteModel;

  MyToDo(this.noteModel);

  @override
  State<MyToDo> createState() {
   return MyToDoState(noteModel);
  }
}

class MyToDoState extends State<MyToDo> {
  ToDoNoteModel noteModel;
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _descriptioncontroller = TextEditingController();

  MyToDoState(this.noteModel);

  @override
  Widget build(BuildContext context) {
    _namecontroller.text = noteModel.note.todo_name;
    _descriptioncontroller.text = noteModel.note.todo_description;

    return Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: Center(
            child: Column(
              children: [
                DateTimeField(
                  decoration: const InputDecoration(hintText: 'Дата события'),
                  selectedDate: noteModel.note.todo_date,
                  onDateSelected: (DateTime value) {
                    setState(() {
                      noteModel.note.todo_date = value;
                    });
                  },

                ),
                Text('Название'),
                TextField(controller: _namecontroller),
                Text('Описание'),
                TextField(controller: _descriptioncontroller),
                Switch(
                    value: noteModel.note.isDone,
                    onChanged: (value) {
                        setState((){
                        noteModel.note.isDone = value;
                        //noteModel.note.todo_date = DateTime.parse(_datecontroller.text);
                        noteModel.note.todo_name = _namecontroller.text;
                        noteModel.note.todo_description = _descriptioncontroller.text;
                      });
                    }),
                FloatingActionButton.extended(
                  onPressed: () {
                    //noteModel.note.todo_date = DateTime.parse(_datecontroller.text);
                    noteModel.note.todo_name = _namecontroller.text;
                    noteModel.note.todo_description = _descriptioncontroller.text;

                    BlocProvider.of<ToDoBloc>(context).add(NoteChange(noteModel));
                    Navigator.pop(
                        context
                    );
                  },
                  label: Text('Сохранить'),
                  icon: Icon(Icons.add),
                  backgroundColor: Colors.amber,
                )
              ],
            )));
  }
}
