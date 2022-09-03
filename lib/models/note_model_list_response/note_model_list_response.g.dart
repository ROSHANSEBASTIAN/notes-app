// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteModelListResponse _$NoteModelListResponseFromJson(
        Map<String, dynamic> json) =>
    NoteModelListResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => NoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NoteModelListResponseToJson(
        NoteModelListResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
