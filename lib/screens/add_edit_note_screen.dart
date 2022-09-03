import 'package:flutter/material.dart';
import 'package:notes_never_forget/api/note_apis.dart';
import 'package:notes_never_forget/models/note_model/note_model.dart';

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

    final _rxdValues =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    _actionType = _rxdValues["actionType"];
    // _id = _rxdValues["id"];

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
                  submitHandler(_title, _description, context);
                },
                child: const Text("Submit"))
          ],
        ),
      ),
    );
  }

  Future<void> submitHandler(
      String title, String description, BuildContext context) async {
    print("Saving");
    if (title.isEmpty || description.isEmpty) {
      return;
    }
    print("Saving 2");
    final _newNote = NoteModel.create(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      content: description,
    );
    print("Saving 3 " + _newNote.toJson().toString());
    final _addedNote = await NoteAPIs().createNote(_newNote);
    if (_addedNote != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("New note added successfully"),
        ),
      );
      Navigator.of(context).pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to add new note"),
        ),
      );
    }
    print("Saving 4");
  }
}
