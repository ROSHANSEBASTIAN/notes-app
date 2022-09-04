import "package:flutter/material.dart";

import '../api/note_apis.dart';
import '../constants/common_constants.dart';
import '../models/note_model/note_model.dart';
import '../constants/route_info.dart';
import '../widgets/atom/home/note_list_item.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<NoteModel> allNotes = [];
    NoteAPIs.instance.getNotesList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes: Never forget"),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<List<NoteModel>>(
        valueListenable: NoteAPIs.instance.noteListNotifier,
        builder: (BuildContext context, List<NoteModel> notesList, Widget? _) {
          print("notesList size " + notesList.length.toString());
          return GridView.builder(
            itemBuilder: (BuildContext ctx, int index) {
              final _noteItem = notesList[index];
              return NotListItem(noteModel: _noteItem);
            },
            itemCount: notesList.length,
            padding: const EdgeInsets.only(bottom: 5),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
          );
        },
      ),
      backgroundColor: Colors.grey[50],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => addNewNoteHandler(context),
        label: const Text("New"),
        icon: const Icon(Icons.add),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void addNewNoteHandler(BuildContext context) {
    Navigator.of(context).pushNamed(add_edit_screen_route, arguments: {
      "actionType": ActionType.addNote,
      "id": null,
    });
  }
}
