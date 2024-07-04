import 'package:crashorcash/domain/models/game_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fetch_game_list.g.dart';

@JsonSerializable()
class GameListResponseModel {
  final String code;
  final String message;
  final DataModel data;

  GameListResponseModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory GameListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GameListResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$GameListResponseModelToJson(this);
}

@JsonSerializable()
class DataModel {
  final List<GameModel> games;

  DataModel({required this.games});

  factory DataModel.fromJson(Map<String, dynamic> json) {
    print('JSON-------------------------------------------------------');
    print(json);
    return _$DataModelFromJson(json);
  }
  Map<String, dynamic> toJson() => _$DataModelToJson(this);
}
