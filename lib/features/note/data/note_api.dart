import '../domain/note_entities.dart';
import 'note_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NoteApi {
  static Future SaveNote(NoteModel noteModel) async {
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
    List<NoteModel> noteModels = res.isNotEmpty ? res.map((element) => NoteFromMap(element)).toList() : [];

    return noteModels;
  }

  static Map<String, dynamic> NoteToMap(NoteModel noteModel) {

    return {'id':noteModel.id,
      'note_created':noteModel.note_created,
      'note_name':noteModel.note_name,
      'note_description':noteModel.note_description};
  }

  static NoteModel NoteFromMap(mapnoteModel) {

    NoteModel noteModel = NoteModel(note_name: mapnoteModel['note_name'],note_description: mapnoteModel['note_description'],note_created: mapnoteModel['note_created']);
    noteModel.id = mapnoteModel['id'];

    return noteModel;
  }
}