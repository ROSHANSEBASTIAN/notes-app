import "package:flutter/material.dart";
import 'package:notes_never_forget/constants/common_constants.dart';

import '../constants/route_info.dart';
import '../widgets/atom/home/note_list_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes: Never forget"),
        centerTitle: true,
      ),
      body: GridView.builder(
        itemBuilder: (BuildContext ctx, int index) => const NotListItem(),
        itemCount: 10,
        padding: const EdgeInsets.only(bottom: 5),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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
