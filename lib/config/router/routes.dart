import 'package:crashorcash/presentation/pages/authentication/authentication.dart';
import 'package:crashorcash/presentation/pages/games/game_details.dart';
import 'package:crashorcash/presentation/pages/games/games.dart';
import 'package:crashorcash/presentation/pages/payment/deposit.dart';
import 'package:crashorcash/presentation/pages/profile/profile.dart';
import 'package:crashorcash/presentation/pages/splashscreen/splashscreen.dart';
import 'package:get/get.dart';

class Routes {
  static final List<GetPage> routes = [
    GetPage(name: "/", page: () => const SplashScreen()),
    GetPage(name: "/auth", page: () => const Authentication()),
    GetPage(name: "/games", page: () => const Games()),
    GetPage(name: "/games/:gameId", page: () => const GameDetails()),
    // GetPage(name: "/payment", page: () => const Payment()),
    GetPage(name: "/depost", page: () => const Deposit()),
    GetPage(name: "/profile", page: () => const Profile())
  ];
}
