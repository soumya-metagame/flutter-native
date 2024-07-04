// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameModel _$GameModelFromJson(Map<String, dynamic> json) => GameModel(
      id: json['_id'] as String,
      defaultBet: (json['defaultBet'] as num?)?.toDouble(),
      maxBet: (json['maxBet'] as num?)?.toDouble(),
      minBet: (json['minBet'] as num?)?.toDouble(),
      gameName: json['gameName'] as String,
      gameAlias: json['gameAlias'] as String,
      launchPath: json['launchPath'] as String?,
      icon: json['icon'] as String,
      gameType: json['gameType'] as String?,
    );

Map<String, dynamic> _$GameModelToJson(GameModel instance) => <String, dynamic>{
      '_id': instance.id,
      'defaultBet': instance.defaultBet,
      'maxBet': instance.maxBet,
      'minBet': instance.minBet,
      'gameName': instance.gameName,
      'gameAlias': instance.gameAlias,
      'launchPath': instance.launchPath,
      'icon': instance.icon,
      'gameType': instance.gameType,
    };
