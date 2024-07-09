import 'package:crashorcash/layout.dart';
import 'package:crashorcash/presentation/controllers/games/games_controller.dart';
import 'package:crashorcash/presentation/controllers/layout/navigation_controller.dart';
import 'package:crashorcash/utils/helpers/user_token_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  var me = UserTokenManager().user;
  final controller = Get.find<NavigationController>();

  String _ellipsize(String text, {int maxLength = 10}) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength)}...';
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => GamesController());
    return Obx(() {
      return Layout(
          child: IndexedStack(
        index: controller.selectedIndex.value,
        children: [
          ...controller.screens,
        ],
      ));
    });
  }
}
