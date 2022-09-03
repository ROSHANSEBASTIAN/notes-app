import 'dart:convert';

import 'package:dio/dio.dart';

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

  NoteAPIs() {
    _dio.options = BaseOptions(
      baseUrl: _noteUrls.baseURL,
      responseType: ResponseType.json,
    );
  }

  @override
  Future<NoteModel?> createNote(NoteModel noteModel) async {
    var _result;
    try {
      _result = await _dio.post(
        _noteUrls.createNote,
        data: noteModel.toJson(),
      );

      return NoteModel.fromJson(_result.data as Map<String, dynamic>);
    } on DioError catch (e) {
      print("DIO Error: " + e.message);
      return null;
    } catch (e) {
      print("Error: " + e.toString());
      return null;
    }
  }

  @override
  Future<void> deleteNote(String noteId) async {
    final _result = await _dio.delete(_noteUrls.baseURL + _noteUrls.deleteNote,
        data: noteId);
  }

  @override
  Future<NoteModel?> editNote(NoteModel noteModel) async {
    final _result = await _dio.put<NoteModel>(
        _noteUrls.baseURL + _noteUrls.updateNote,
        data: noteModel);
    return _result.data;
  }

  @override
  Future<List<NoteModel>?> getNotesList() async {
    final _result = await _dio
        .get<NoteModelListResponse>(_noteUrls.baseURL + _noteUrls.getAllNotes);
    return _result.data != null ? _result.data!.data : [];
  }
}
