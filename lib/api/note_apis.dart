import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../models/note_model_list_response/note_model_list_response.dart';
import '../api/note_urls.dart';
import '../models/note_model/note_model.dart';

abstract class APICalls {
  Future<NoteModel?> createNote(NoteModel noteModel);

  Future<List<NoteModel>?> getNotesList();

  Future<NoteModel?> editNote(NoteModel noteModel);

  Future<void> deleteNote(String noteId);
}

class NoteAPIs extends APICalls {
  final _dio = Dio();
  final _noteUrls = NoteURLs();
  final ValueNotifier<List<NoteModel>> noteListNotifier = ValueNotifier([]);

  // singleton

  NoteAPIs._internal();

  static NoteAPIs instance = NoteAPIs._internal();

  factory() {
    _dio.options = BaseOptions(
      baseUrl: _noteUrls.baseURL,
      responseType: ResponseType.json,
      contentType: "json",
    );
    return instance;
  }
  // end of singleton

  @override
  Future<NoteModel?> createNote(NoteModel noteModel) async {
    var _result;
    try {
      _result = await _dio.post(
        _noteUrls.baseURL + _noteUrls.createNote,
        data: noteModel.toJson(),
      );
      noteListNotifier.value.add(noteModel);
      noteListNotifier.notifyListeners();

      return NoteModel.fromJson(_result.data as Map<String, dynamic>);
    } on DioError catch (e) {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> deleteNote(String noteId) async {
    try {
      final _result = await _dio.delete(_noteUrls.baseURL +
          _noteUrls.deleteNote.replaceFirst("{id}", noteId));
      final _selectedIndex =
          noteListNotifier.value.indexWhere((element) => element.id == noteId);
      if (_selectedIndex != -1) {
        noteListNotifier.value.removeAt(_selectedIndex);
        noteListNotifier.notifyListeners();
      }
    } on DioError catch (e) {
    } catch (e) {
      return;
    }
  }

  @override
  Future<NoteModel?> editNote(NoteModel? noteModel) async {
    try {
      final _result = await _dio.put(
        _noteUrls.baseURL + _noteUrls.updateNote,
        data: noteModel!.toJson(),
      );
      print("Value sent " + noteModel.content.toString());
      print("Edit response is " + _result.toString());

      final itemIndex = noteListNotifier.value
          .indexWhere((element) => element.id == noteModel.id);
      if (itemIndex != -1) {
        noteListNotifier.value[itemIndex].title = noteModel.title;
        noteListNotifier.value[itemIndex].content = noteModel.content;
        noteListNotifier.notifyListeners();
      }

      return NoteModel.fromJson(_result.data as Map<String, dynamic>);
    } on DioError catch (e) {
      print("DIO error " + e.message);
      return null;
    } catch (e) {
      print("error " + e.toString());
      return null;
    }
  }

  @override
  Future<List<NoteModel>?> getNotesList() async {
    print("getNotesList called");
    final _result = await _dio.get(_noteUrls.baseURL + _noteUrls.getAllNotes);
    if (_result.data != null) {
      final noteListResponse = NoteModelListResponse.fromJson(_result.data);
      noteListNotifier.value.clear();
      noteListNotifier.value = noteListResponse.data ?? [];
      noteListNotifier.notifyListeners();
      print("Note list size: " + noteListNotifier.value.length.toString());
    } else {
      noteListNotifier.value.clear();
      noteListNotifier.notifyListeners();
      // return [];
    }
  }
}
