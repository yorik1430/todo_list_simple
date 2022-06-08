import '../domain/note_entities.dart';
import 'note_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NoteApi {
  static Future SaveNote(Note noteModel) async {
    final box = await Hive.openBox('ToDoes01');
    if (noteModel.id == null) {
      int id = await box.add('');
      noteModel.id = id;
    }
    final valueToDo = NoteToMap(noteModel);
    await box.put(noteModel.id, valueToDo);
  }

  static Future<List<NoteModel>> GetNotes() async {
    final box = await Hive.openBox('ToDoes01');
    final res = await box.values;
    List<NoteModel> noteModels = res.isNotEmpty ? res.where((element) => element != '').map((element) => NoteFromMap(element)).toList() : [];

    return noteModels;
  }

  static Map<String, dynamic> NoteToMap(Note noteModel) {

    return {'id':noteModel.id,
      'note_created':noteModel.note_created,
      'note_name':noteModel.note_name,
      'note_description':noteModel.note_description,
      'toDoid':noteModel.toDoid};
  }

  static NoteModel NoteFromMap(mapnoteModel) {

    NoteModel noteModel = NoteModel(name: mapnoteModel['note_name'],description: mapnoteModel['note_description'],created: mapnoteModel['note_created'],toDoid: mapnoteModel['toDoid']);
    noteModel.id = mapnoteModel['id'];

    return noteModel;
  }
}