import 'package:crashorcash/presentation/pages/games/games.dart';
import 'package:crashorcash/presentation/pages/payment/deposit.dart';
import 'package:crashorcash/presentation/pages/profile/edit_profile.dart';
import 'package:crashorcash/presentation/pages/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const Games(),
    Container(color: Colors.blue), // Replace with your actual widget
    const Deposit(), // Replace with your actual widget
    Container(color: Colors.red), // Replace with your actual widget
    const Profile(),
    const EditProfile() // Replace with your actual widget
  ];

  void navigateTo(int index) {
    switch (index) {
      // ignore: constant_pattern_never_matches_value_type
      case 0:
        Get.toNamed("/games");
        break;
      case 2:
        Get.toNamed("/deposit");
        break;
      case 4:
        Get.toNamed("/profile");
        break;
      default:
    }
  }

  void navigateToEditProfile() {
    Get.toNamed("/edit-profile");
  }
}
