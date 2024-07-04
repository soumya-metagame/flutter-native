import 'dart:convert';
import 'dart:typed_data';

import 'package:crashorcash/data/datesources/remote/games/fetch_game_list_api.dart';
import 'package:crashorcash/domain/models/game_model.dart';
import 'package:crashorcash/domain/models/res/fetch_game_list.dart';
import 'package:crashorcash/utils/helpers/image_manager.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class GamesController extends GetxController {
  var games = <GameModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _fetchGameList();
  }

  Future<void> _fetchGameList() async {
    try {
      final response = await fetchGameList();

      if (response is GameListResponseModel && response.code == 'G200') {
        games.value = response.data.games;

        for (var game in games) {
          await processGameIcon(game.icon);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> processGameIcon(String iconUrl) async {
    final dio = Dio();

    final imageName = iconUrl.split('/').last.split('.').first;

    if (ImageManager().containsImage(imageName)) {
      print('Image already exists in the database');
      return;
    }

    try {
      final response = await dio.get(
        iconUrl,
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        final bytes = response.data;

        final base64Image = base64Encode(bytes);

        await ImageManager.instance
            .addImage(imageName: imageName, base64: base64Image);
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      print('Error fetching image: $e');
    }
  }

  Future<Map<String, dynamic>> getImageInfo(String iconUrl) async {
    final imageName = iconUrl.split('/').last.split('.').first;

    dynamic base64Image = ImageManager.instance.getImage(imageName);

    if (base64Image == null) {
      return {'isBase64': false, 'imageData': iconUrl};
    }

    Uint8List bytes = base64Decode(base64Image);

    return {'isBase64': true, 'imageData': bytes};
  }
}
