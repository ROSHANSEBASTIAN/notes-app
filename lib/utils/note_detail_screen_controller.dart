import 'package:notes_never_forget/api/note_apis.dart';
import 'package:notes_never_forget/models/note_model/note_model.dart';

NoteModel? getNoteById(String id) {
  try {
    return NoteAPIs.instance.noteListNotifier.value
        .firstWhere((element) => element.id == id);
  } catch (e) {
    return null;
  }
}
