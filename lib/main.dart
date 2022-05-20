import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'features/note/ui/note_list_view.dart';
import 'features/note/ui/note_list_viewmodel.dart';
import 'features/todo/ui/todo_list_view.dart';
import 'features/todo/ui/todo_list_viewmodel.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Hive.initFlutter();
  runApp(BlocProvider(create: (context) => ToDoBloc(ToDoesEmpty()) , child: BlocProvider(create: (context) => NoteBloc(NotesEmpty()) , child:MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyApp()))));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: Text('Список задач и заметок Машеньки'),
            ),
            body: Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => NotesPage()));
                      },
                      child: Container(
                          padding: EdgeInsets.all(20),
                          child: Text('Список заметок Машеньки'))),
                  Container(padding: EdgeInsets.all(20), child: Text('')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => ToDoesPage()));
                      },
                      child: Container(
                          padding: EdgeInsets.all(20),
                          child: Text(' Список задач Машеньки ')))
                ],
              ),
            ));
  }
}
