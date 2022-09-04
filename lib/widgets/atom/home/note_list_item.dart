import 'package:flutter/material.dart';
import 'package:notes_never_forget/api/note_apis.dart';

import '../../../constants/common_constants.dart';
import '../../../constants/route_info.dart';
import '../../../models/note_model/note_model.dart';

class NotListItem extends StatelessWidget {
  const NotListItem({Key? key, required this.noteModel}) : super(key: key);
  final NoteModel noteModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => noteTapHandler(context, noteModel.id),
      child: Padding(
        padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
        child: Card(
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(width: 1, color: Colors.white),
          ),
          elevation: 10.0,
          margin: const EdgeInsets.only(top: 5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Text(
                        noteModel.title ?? "Here comes the title",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        onPressed: () => deleteNote(noteModel.id),
                        icon: const Icon(Icons.delete, color: Colors.red),
                      ),
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                Expanded(
                  child: Text(
                    noteModel.content ?? "Lorem ipsum dolor sit amet",
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deleteNote(String? noteId) {
    if (noteId != null) {
      NoteAPIs.instance.deleteNote(noteId);
    }
  }

  void noteTapHandler(BuildContext context, String? selectedId) {
    Navigator.of(context).pushNamed(
      add_edit_screen_route,
      arguments: {
        "id": selectedId,
        "actionType": ActionType.editNote,
      },
    );
  }
}
