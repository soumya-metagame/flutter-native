
import 'package:crashorcash/data/datesources/remote/games/fetch_game_launchurl_api.dart';
import 'package:crashorcash/domain/models/res/fetch_game_launchUrl_res.dart';
import 'package:get/get.dart';

class GameDetailsController extends GetxController {
  String? link;
  late String gameId;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print("GAME: $gameId");
    _fetchGameLaunchUrl();
  }

  Future<void> _fetchGameLaunchUrl() async {
    try {
      final response = await fetchGameLaunchUrl(gameId);

      if (response is FetchGameLaunchUrlResponse && response.code == 'G201') {
        link = response.launchUrl;
        print("LINK: $link");
      }
    } catch (e) {
      print(e);
    }
  }
}
