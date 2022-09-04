import 'dart:io';

import 'package:flutter/material.dart';

import '../api/note_apis.dart';
import '../models/note_model/note_model.dart';
import '../utils/note_detail_screen_controller.dart';
import '../constants/common_constants.dart';

class AddEditNoteScreen extends StatefulWidget {
  const AddEditNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  @override
  Widget build(BuildContext context) {
    ActionType _actionType = ActionType.addNote;
    String _id;
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    NoteModel? _selectedNote;

    final _rxdValues =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    _actionType = _rxdValues["actionType"];

    if (_actionType == ActionType.editNote) {
      print("Edit mode");
      _id = _rxdValues["id"];
      if (_id == null) {
        Navigator.of(context).pop();
      } else {
        _selectedNote = getNoteById(_id);
        if (_selectedNote == null) {
          Navigator.of(context).pop();
        } else {
          // populating fields
          titleController.text = _selectedNote.title ?? "";
          descriptionController.text = _selectedNote.content ?? "";
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _actionType == ActionType.addNote ? "Add Note" : "Edit Note",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: descriptionController,
              maxLines: 5,
              maxLength: 100,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  final _title = titleController.text;
                  final _description = descriptionController.text;
                  submitHandler(
                    _title,
                    _description,
                    context,
                    _actionType,
                    _selectedNote,
                  );
                },
                child:
                    Text(_actionType == ActionType.addNote ? "Add" : "Update"))
          ],
        ),
      ),
    );
  }

  Future<void> submitHandler(
      String title,
      String description,
      BuildContext context,
      ActionType actionType,
      NoteModel? selectedNote) async {
    print("Saving " + title + ", " + description);
    if (title.isEmpty || description.isEmpty) {
      return;
    }
    NoteModel? _savedNote;
    if (actionType == ActionType.addNote) {
      print("Saving 2");
      final _newNote = NoteModel.create(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        content: description,
      );
      print("Saving 3 " + _newNote.toJson().toString());
      _savedNote = await NoteAPIs.instance.createNote(_newNote);
    } else {
      _savedNote = await NoteAPIs.instance.editNote(NoteModel(
        content: description,
        title: title,
        id: selectedNote?.id,
      ));
    }

    if (_savedNote != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(actionType == ActionType.addNote
              ? "New note added successfully"
              : "Note edited successfully"),
        ),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to save note"),
        ),
      );
    }
    print("Saving 4");
  }
}
