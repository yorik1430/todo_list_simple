import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../todo/domain/todo_entities.dart';
import '../../todo/ui/todo_list_view.dart';
import '../data/note_model.dart';
import '../data/note_repositary.dart';
import '../domain/note_entities.dart';
import 'note_list_viewmodel.dart';

final noteListProvider = StateNotifierProvider<NoteBloc, List<Note>>((ref) {
  NoteBloc noteBloc = NoteBloc([]);
  noteBloc.NotesReceive();
  return noteBloc;
});

class NotesPage extends ConsumerWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Список записей'),
      ),
      body: Center(child: Consumer(builder: (BuildContext context, ref, _) {
        List<Note> notes = ref.watch(noteListProvider);

        return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (cont, index) => ListTile(
                leading: Text(notes[index].note_created.toString()),
                title: Text(notes[index].note_name ?? ''),
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => MyNote(notes[index])),
                    )));
      })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => MyNote(NoteModel())));
        },
        tooltip: 'Добавить заметку',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyNote extends StatefulWidget {
  Note note;

  MyNote(this.note);

  @override
  State<MyNote> createState() {
    return MyNoteState(note);
  }
}

class MyNoteState extends State<MyNote> {
  Note note;
  TextEditingController _createdcontroller = TextEditingController();
  TextEditingController _namecontroller = TextEditingController();
  TextEditingController _descriptioncontroller = TextEditingController();

  MyNoteState(this.note);

  @override
  Widget build(BuildContext context) {
    _createdcontroller.text = note.note_created.toString();
    _namecontroller.text = note.note_name ?? '';
    _descriptioncontroller.text = note.note_description ?? '';

    return Scaffold(
        appBar: AppBar(
          title: Text(''),
        ),
        body: Center(
            child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text('Дата создания'),
                    TextField(controller: _createdcontroller, readOnly: true),
                    Text('Название заметки'),
                    TextField(controller: _namecontroller),
                    Text('Описание заметки'),
                    TextField(controller: _descriptioncontroller),
                    Text('К задаче'),
                    Consumer(builder: (BuildContext context, ref, _) {
                      List<ToDo> listToDoes = ref.read(todoListProvider);
                      ToDo? dropdownValue = note.toDoid == null || listToDoes.length == 0 ? null : listToDoes.firstWhere((toDo) => toDo.id == note.toDoid);
                      return DropdownButton<ToDo?>(
                        value: dropdownValue,
                        onChanged: (ToDo? newValue) {
                          setState(() {
                            if (newValue == null)
                              note.toDoid = null;
                            else
                              note.toDoid = newValue.id;
                          });
                        },
                        items: listToDoes.map<DropdownMenuItem<ToDo>>((ToDo value) {
                          return DropdownMenuItem<ToDo>(
                            value: value,
                            child: Text(value.todo_name),
                          );
                        }).toList(),
                      );
                    }),
                    Consumer(builder: (BuildContext context, ref, _) {
                      return FloatingActionButton.extended(
                        onPressed: () {
                          note.note_name = _namecontroller.text;
                          note.note_description = _descriptioncontroller.text;

                          NoteListSaver(note).SaveNote().then((value) => ref.read(noteListProvider.notifier).NotesReceive());
                          Navigator.pop(context);
                        },
                        label: Text('Сохранить'),
                        icon: Icon(Icons.add),
                        backgroundColor: Colors.amber,
                      );
                    })
                  ],
                ))));
  }
}
