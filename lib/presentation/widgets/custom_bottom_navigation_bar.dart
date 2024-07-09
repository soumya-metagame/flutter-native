import 'package:crashorcash/presentation/controllers/layout/navigation_controller.dart';

import 'build_nav_item.dart';
import 'package:crashorcash/utils/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Container(
      height: 80,
      decoration: const BoxDecoration(
        gradient: AppColor.bottomNavBarGradient,
        border: Border(
          top: BorderSide(
            color: AppColor.sunglow,
            width: 2.0,
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/circleRadialDesign2-faded.png",
              height: 40,
              // fit: BoxFit.cover,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildNavItem(
                  iconPath: "assets/images/games_icon.png",
                  label: "Games",
                  index: 0,
                  isActive: controller.selectedIndex.value == 0,
                  controller: controller),
              buildNavItem(
                  iconPath: "assets/images/how-to-play.png",
                  label: "Hot To Play",
                  index: 1,
                  isActive: controller.selectedIndex.value == 1,
                  controller: controller),
              buildNavItem(
                  isSpecial: true,
                  iconPath: "assets/images/add_cash.png",
                  label: "Add Cash",
                  index: 2,
                  isActive: controller.selectedIndex.value == 2,
                  controller: controller),
              buildNavItem(
                  iconPath: "assets/images/activity.png",
                  label: "Activity",
                  index: 3,
                  isActive: controller.selectedIndex.value == 3,
                  controller: controller),
              buildNavItem(
                  isProfile: true,
                  iconPath: "assets/images/tom.jpg",
                  label: "Activity",
                  index: 4,
                  isActive: controller.selectedIndex.value == 4,
                  controller: controller),
            ],
          ),
        ],
      ),
    );
  }
}
