import 'package:flutter/material.dart';

import '../constants/common_constants.dart';

class AddEditNoteScreen extends StatelessWidget {
  const AddEditNoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ActionType _actionType = ActionType.addNote;

    final _rxdValues =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print("Rxd values are");
    print(_rxdValues.toString());
    print(_rxdValues["actionType"]);
    print(_rxdValues["actionType"].runtimeType);
    _actionType = _rxdValues["actionType"];
    // String _id = _rxdValues["id"];

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
                onPressed: () => submitHandler(), child: const Text("Submit"))
          ],
        ),
      ),
    );
  }

  void submitHandler() {}
}
