// ignore_for_file: must_be_immutable

import 'package:crashorcash/presentation/widgets/build_nav_item.dart';
import 'package:crashorcash/utils/constants/app_color.dart';
import 'package:crashorcash/utils/helpers/user_token_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:crashorcash/presentation/controllers/layout/navigation_controller.dart';

class Layout extends StatelessWidget {
  Widget child;

  Layout({required this.child, super.key});

  final me = UserTokenManager().user;

  final _navigationController = Get.put(NavigationController());

  String _ellipsize(String text, {int maxLength = 10}) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength)}...';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.black,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        me['name'] ?? _ellipsize(me['_id']),
                        textAlign: TextAlign.left,
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Stack(clipBehavior: Clip.none, children: [
                        Container(
                            padding: const EdgeInsets.all(1.0),
                            decoration: BoxDecoration(
                              gradient: AppColor.yellowGradient,
                              borderRadius: BorderRadius.circular(14.0),
                            ),
                            child: Container(
                              width: 140,
                              padding:
                                  const EdgeInsets.only(top: 3.0, bottom: 3.0),
                              decoration: BoxDecoration(
                                  gradient: AppColor.primaryBrownGradient,
                                  borderRadius: BorderRadius.circular(14.0)),
                              child: Text(
                                (me['balance']['currentBalance'] as num?)
                                        ?.toDouble()
                                        .toStringAsFixed(2) ??
                                    "0.00",
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.0),
                                textAlign: TextAlign.center,
                                maxLines: 8,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )),
                        Positioned(
                          top: -2,
                          left: -10,
                          child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                gradient: AppColor.yellowGradient,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    width: 2.0, color: AppColor.brown_3)),
                            child: const Text(
                              '\u{20B9}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: AppColor.brown_3,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 4,
                            right: -25,
                            child: GestureDetector(
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: SvgPicture.asset(
                                  "assets/images/loader.svg",
                                  color: AppColor.sunglow,
                                  width: 10.0,
                                ),
                              ),
                            ))
                      ])
                    ],
                  ),
                  Image.asset(
                    "assets/images/Logo.png",
                    width: 78,
                  )
                ],
              ),
            ),
          ],
        ),
        titleTextStyle: const TextStyle(
          color: AppColor.yellow,
        ),
        leading: Container(),
        leadingWidth: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: AppColor.appBarGradient),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/lobby-blurred-bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: child,
      ),
      bottomNavigationBar: Container(
        height: 80,
        decoration: const BoxDecoration(
            gradient: AppColor.bottomNavBarGradient,
            border: Border(
                top: BorderSide(
              color: AppColor.sunglow,
              width: 2.0,
            ))),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/images/circleRadialDesign2-faded.png",
                height: 40,
                // fit: BoxFit.cover,
              ),
            ),
            GridView.count(
              crossAxisCount: 5,
              children: [
                buildNavItem(
                    iconPath: "assets/images/games_icon.png",
                    label: "Games",
                    index: 0,
                    isActive: _navigationController.selectedIndex.value == 0,
                    controller: _navigationController),
                buildNavItem(
                    iconPath: "assets/images/how-to-play.png",
                    label: "Hot To Play",
                    index: 1,
                    isActive: _navigationController.selectedIndex.value == 1,
                    controller: _navigationController),
                buildNavItem(
                    isSpecial: true,
                    iconPath: "assets/images/add_cash.png",
                    label: "Add Cash",
                    index: 2,
                    isActive: _navigationController.selectedIndex.value == 2,
                    controller: _navigationController),
                buildNavItem(
                    iconPath: "assets/images/activity.png",
                    label: "Activity",
                    index: 3,
                    isActive: _navigationController.selectedIndex.value == 3,
                    controller: _navigationController),
                buildNavItem(
                    isProfile: true,
                    iconPath: "assets/images/tom.jpg",
                    label: "My Account",
                    index: 4,
                    isActive: _navigationController.selectedIndex.value == 4,
                    controller: _navigationController),
              ],
            )
          ],
        ),
      ),
    );
  }
}
