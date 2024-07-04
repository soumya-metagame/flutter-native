import 'package:json_annotation/json_annotation.dart';

part 'game_model.g.dart';

@JsonSerializable()
class GameModel {
  @JsonKey(name: '_id')
  final String id;

  final double? defaultBet;
  final double? maxBet;
  final double? minBet;
  final String gameName;
  final String gameAlias;
  final String? launchPath;
  final String icon;
  final String? gameType;

  GameModel({
    required this.id,
    this.defaultBet,
    this.maxBet,
    this.minBet,
    required this.gameName,
    required this.gameAlias,
    this.launchPath,
    required this.icon,
    this.gameType,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) =>
      _$GameModelFromJson(json);

  Map<String, dynamic> toJson() => _$GameModelToJson(this);
}
