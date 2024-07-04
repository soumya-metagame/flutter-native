// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_game_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameListResponseModel _$GameListResponseModelFromJson(
        Map<String, dynamic> json) =>
    GameListResponseModel(
      code: json['code'] as String,
      message: json['message'] as String,
      data: DataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GameListResponseModelToJson(
        GameListResponseModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

DataModel _$DataModelFromJson(Map<String, dynamic> json) => DataModel(
      games: (json['games'] as List<dynamic>)
          .map((e) => GameModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DataModelToJson(DataModel instance) => <String, dynamic>{
      'games': instance.games,
    };
