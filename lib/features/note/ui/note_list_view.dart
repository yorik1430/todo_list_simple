import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../data/note_repositary.dart';
import 'note_list_viewmodel.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Список записей'),
      ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: BlocBuilder<NoteBloc, NoteStates>(
              builder: (BuildContext context, state) {
        if (state is NotesEmpty) {
          BlocProvider.of<NoteBloc>(context).add(NotesReceive());
          return Text('данные начинают считыватся');
        }
        if (state is Notereceived) {
          return ListView.builder(
            itemCount: state.noteModels.length,
              itemBuilder: (cont, index) => ListTile(
                leading: Text(state.noteModels[index].note.note_created.toString()),
                  title: Text(state.noteModels[index].note.note_name),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => MyNote(state.noteModels[index])),
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
              MaterialPageRoute(builder: (_) => MyNote(GetIt.instance<NoteModel>())));
        },
        tooltip: 'Добавить заметку',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyNote extends StatefulWidget {
  NoteModel noteModel;

  MyNote(this.noteModel);

  @override
  State<MyNote> createState() {
   return MyMyNoteState(noteModel);
  }
}

class MyMyNoteState extends State<MyNote> {
  NoteModel noteModel;
  TextEditingController _createdcontroller = TextEditingController();
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _descriptioncontroller = TextEditingController();

  MyMyNoteState(this.noteModel);

  @override
  Widget build(BuildContext context) {
    _createdcontroller.text = noteModel.note.note_created.toString();
    _namecontroller.text = noteModel.note.note_name;
    _descriptioncontroller.text = noteModel.note.note_description;

    return Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: Center(
            child: Container(padding: EdgeInsets.all(20), child:Column(
              children: [
                Text('Дата создания'),
                TextField(controller: _createdcontroller, readOnly: true),
                Text('Название заметки'),
                TextField(controller: _namecontroller),
                Text('Описание заметки'),
                TextField(controller: _descriptioncontroller),
                FloatingActionButton.extended(
                  onPressed: () {
                    noteModel.note.note_name = _namecontroller.text;
                    noteModel.note.note_description = _descriptioncontroller.text;

                    BlocProvider.of<NoteBloc>(context).add(NoteChange(noteModel));
                    Navigator.pop(
                        context
                    );
                  },
                  label: Text('Сохранить'),
                  icon: Icon(Icons.add),
                  backgroundColor: Colors.amber,
                )
              ],
            ))));
  }
}
