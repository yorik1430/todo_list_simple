import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/note_model.dart';
import '../data/note_repositary.dart';
import '../domain/note_entities.dart';
import 'note_list_viewmodel.dart';

final noteListProvider =
    StateNotifierProvider<NoteBloc, List<NoteModel>>((ref) {
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
        List<NoteModel> noteModels = ref.watch(noteListProvider);

        return ListView.builder(
            itemCount: noteModels.length,
            itemBuilder: (cont, index) => ListTile(
                leading: Text(noteModels[index].note_created.toString()),
                title: Text(noteModels[index].note_name),
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => MyNote(noteModels[index])),
                    )));
      })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => MyNote(NoteModel())));
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
    _createdcontroller.text = noteModel.note_created.toString();
    _namecontroller.text = noteModel.note_name;
    _descriptioncontroller.text = noteModel.note_description;

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
                    Consumer(builder: (BuildContext context, ref, _) {
                      return FloatingActionButton.extended(
                        onPressed: () {
                          noteModel.note_name = _namecontroller.text;
                          noteModel.note_description =
                              _descriptioncontroller.text;

                          NoteListSaver(noteModel).SaveNote();
                          ref.read(noteListProvider.notifier).NotesReceive();
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
