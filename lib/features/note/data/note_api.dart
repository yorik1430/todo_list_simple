import 'package:get_it/get_it.dart';

import '../domain/note_entities.dart';
import 'note_repositary.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NoteApi {
  static Future SaveToDo(NoteModel noteModel) async {
    final box = await Hive.openBox('ToDoes1');
    if (noteModel.id == null) {
      int id = await box.add('');
      noteModel.id = id;
    }
    final valueToDo = NoteToMap(noteModel);
    await box.put(noteModel.id, valueToDo);
  }

  static Future<List<NoteModel>> GetToDoes() async {
    final box = await Hive.openBox('ToDoes1');
    final res = await box.values;
    List<NoteModel> noteModels = res.isNotEmpty ? res.map((element) => NoteFromMap(element)).toList() : [];

    return noteModels;
  }

  static Map<String, dynamic> NoteToMap(NoteModel noteModel) {
    return {'id':noteModel.id,
      'note_created':noteModel.note.note_created,
      'note_name':noteModel.note.note_name,
      'note_description':noteModel.note.note_description};
  }

  static NoteModel NoteFromMap(mapnoteModel) {

    NoteModel noteModel = GetIt.instance<NoteModel>();
    noteModel.id = mapnoteModel['id'];
    noteModel.note.note_created = mapnoteModel['note_created'];
    noteModel.note.note_name = mapnoteModel['note_name'];
    noteModel.note.note_description = mapnoteModel['note_description'];

    return noteModel;
  }
}