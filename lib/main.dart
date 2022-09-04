import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './constants/route_info.dart';
import './screens/add_edit_note_screen.dart';
import './screens/home_screen.dart';

void main() {
  runApp(const NoteApp());
}

class NoteApp extends StatelessWidget {
  const NoteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      routes: {
        home_screen_route: (context) => HomeScreen(),
        add_edit_screen_route: (context) => AddEditNoteScreen(),
      },
    );
  }
}
