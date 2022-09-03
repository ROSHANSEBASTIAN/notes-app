import 'package:json_annotation/json_annotation.dart';
import 'package:notes_never_forget/models/note_model/note_model.dart';

part 'note_model_list_response.g.dart';

@JsonSerializable()
class NoteModelListResponse {
  @JsonKey(name: "data")
  List<NoteModel>? data;

  NoteModelListResponse({this.data});

  factory NoteModelListResponse.fromJson(Map<String, dynamic> json) {
    return _$NoteModelListResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NoteModelListResponseToJson(this);
}
