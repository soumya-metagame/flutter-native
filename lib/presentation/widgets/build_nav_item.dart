import 'package:crashorcash/presentation/controllers/layout/navigation_controller.dart';
import 'package:crashorcash/utils/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget buildNavItem({
  required String iconPath,
  required String label,
  required int index,
  bool isActive = false,
  required NavigationController controller,
  bool isSpecial = false,
  bool isProfile = false,
}) {
  return GestureDetector(
      onTap: () {
        controller.selectedIndex.value = index;
        controller.navigateTo(index);
        // Get.to(() => Get.to(() => Get.to("/games")));
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          // if (isActive)
          //   Positioned(
          //     top: 0,
          //     left: 0,
          //     right: 0,
          //     child: Image.asset(
          //       "assets/images/Spotlight.png",
          //       height: 80, // Ensure the height matches the bottom nav bar
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isSpecial)
                Transform.translate(
                  offset: const Offset(0, -10),
                  child: Transform.scale(
                    scale: 1.4,
                    child: Image.asset(
                      iconPath,
                      width: 40.0,
                    ),
                  ),
                )
              else if (isProfile)
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    iconPath,
                    width: 40.0,
                  ),
                )
              else
                Image.asset(
                  iconPath,
                  width: 40.0,
                ),
              Text(
                label,
                style: GoogleFonts.montserrat(
                  color: AppColor.text_yellow,
                  fontSize: 11.0,
                ),
              ),
            ],
          ),
        ],
      ));
}
