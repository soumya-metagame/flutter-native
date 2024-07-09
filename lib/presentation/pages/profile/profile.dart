import 'package:crashorcash/layout.dart';
import 'package:crashorcash/presentation/controllers/layout/navigation_controller.dart';
import 'package:crashorcash/presentation/controllers/profile/logout_controller.dart';
import 'package:crashorcash/presentation/widgets/gradient-text.dart';
import 'package:crashorcash/utils/constants/app_color.dart';
import 'package:crashorcash/utils/helpers/user_token_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:toastification/toastification.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var me = UserTokenManager().user;

  final NavigationController _navigationController = NavigationController();

  final List<Map<String, dynamic>> links = [
    {"name": "EDIT PROFILE", "link": "/edit-profile"},
    {"name": "CHANGE PASSWORD", "link": "/edit-password"},
    {"name": "UPDATE ADDRESS", "link": "/update-address"},
    {"name": "UPDATE KYC", "link": "/update-kyc"},
    {"name": "ACCOUNT SUMMARY", "link": "/account-summary"}
  ];

  List<Widget> navLinks = List.empty();

  final LogoutController logoutController = Get.put(LogoutController());

  String _ellipsize(String text, {int maxLength = 10}) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength)}...';
  }

  Future<void> _logout() async {
    logoutController.loading = true;

    try {
      final response = await logoutController.logout();

      if (response.code == 'PS407') {
        toastification.show(
          style: ToastificationStyle.minimal,
          type: ToastificationType.success,
          title: Text(response.message),
          autoCloseDuration: const Duration(seconds: 5),
          alignment: Alignment.topCenter,
          borderRadius: BorderRadius.circular(12),
          showProgressBar: true,
          closeButtonShowType: CloseButtonShowType.always,
          direction: TextDirection.ltr,
        );
        Get.offAndToNamed('/auth');
      }
    } catch (e) {
      print(e);
    } finally {
      logoutController.loading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/lobby-blurred-bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: AppColor.primaryRedGradient,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(26.0),
                    topRight: Radius.circular(26.0),
                  ),
                ),
                height: MediaQuery.of(context).size.height - 260,
                child: Stack(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: const Alignment(0.0, 2.5),
                      children: [
                        Container(
                          height: 88,
                          decoration: const BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(26.0),
                              topRight: Radius.circular(26.0),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          bottom: 0,
                          right: 0,
                          child: Image.asset(
                            "assets/images/Subtract.png",
                            height: 88,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 160,
                          child: Image.asset(
                            "assets/images/Badge.png",
                            height: 58,
                          ),
                        ),
                        Positioned(
                          bottom: 2,
                          right: 18,
                          child: ShaderMask(
                            shaderCallback: (bounds) {
                              return AppColor.yellowGradient.createShader(
                                  Rect.fromLTWH(
                                      0, 0, bounds.width, bounds.height));
                            },
                            child: Text(
                              _ellipsize(me['name'], maxLength: 10),
                              style: GoogleFonts.montserrat(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 28,
                          right: 0,
                          child: Row(
                            children: [
                              const GradientText(
                                  text: "STATUS",
                                  gradient: AppColor.yellowGradient),
                              const SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 68,
                                padding: const EdgeInsets.all(1.0),
                                decoration: const BoxDecoration(
                                  gradient: AppColor.yellowGradient,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(50.0),
                                    bottomLeft: Radius.circular(
                                      50.0,
                                    ),
                                  ),
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50.0),
                                      bottomLeft: Radius.circular(
                                        50.0,
                                      ),
                                    ),
                                    gradient: AppColor.purpleGradient,
                                  ),
                                  child: Text(
                                    "VIP",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          right: 18,
                          top: 0,
                          child: Row(
                            children: [
                              Text(
                                "ID: ",
                                style: GoogleFonts.montserrat(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Text(
                                _ellipsize(
                                  me['_id'],
                                  maxLength: 10,
                                ),
                                style: GoogleFonts.montserrat(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 114,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black45,
                          ),
                          height: 250,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '\u{20B9} 2.00',
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.yellow,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        'DEPOSITS',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          color: AppColor.yellow,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '\u{20B9} 2.00',
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.yellow,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        'WINNINGS',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          color: AppColor.yellow,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '\u{20B9} 2.00',
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.yellow,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        'TOTAL CASH',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          color: AppColor.yellow,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '\u{20B9} 2.00',
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          color: AppColor.yellow,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        'BONUS',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 18,
                                          color: AppColor.yellow,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: 40,
                                width: 150,
                                padding: const EdgeInsets.all(1),
                                decoration: BoxDecoration(
                                  gradient: AppColor.yellowGradient,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  height: 10,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    gradient: AppColor.primaryBlueGradient,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                    ),
                                    child: const Text(
                                      'Withdraw',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 18,
                      top: 50,
                      child: Container(
                        height: 100,
                        width: 100,
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          gradient: AppColor.yellowGradient,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: Image.asset(
                            "assets/images/tom.jpg",
                            // width: 40.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 50,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40,
                              width: 190,
                              padding: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                gradient: AppColor.yellowGradient,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                height: 10,
                                width: 20,
                                decoration: BoxDecoration(
                                  gradient: AppColor.primaryBlueGradient,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    _showUpdateDrawer();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  child: const Text(
                                    'Update Details',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 118,
                              padding: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                gradient: AppColor.yellowGradient,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                height: 10,
                                width: 20,
                                decoration: BoxDecoration(
                                  gradient: AppColor.primaryRedGradient,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    _showConfirmLogoutDrawer();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  child: const Text(
                                    'Logout',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showConfirmLogoutDrawer() {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: const BoxDecoration(
                gradient: AppColor.primaryRedGradient,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(26.0),
                    topRight: Radius.circular(26.0))),
            height: 600,
            child: Center(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const GradientText(
                    text: 'CONFIRM LOG OUT',
                    gradient: AppColor.yellowGradient,
                    textType: TextType.heading,
                  ),
                  Image.asset(
                    'assets/images/anim-warning.gif',
                    height: 100,
                  ),
                  const GradientText(
                    text:
                        "Are you sure you want to logout?\nLogging out will terminate your\ncurrent session and require you to\nlog in again to access your account",
                    textType: TextType.subtitle,
                    gradient: AppColor.yellowGradient,
                    // textAlign: TextAlign.center,
                    // style: GoogleFonts.montserrat(
                    //   color: AppColor.yellow,
                    //   fontSize: 16,
                    //   fontWeight: FontWeight.w400,
                    // ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 40,
                        width: 150,
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          gradient: AppColor.yellowGradient,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: AppColor.primaryBlueGradient,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            child: const Text(
                              'CANCEL',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 150,
                        padding: const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          gradient: AppColor.yellowGradient,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: AppColor.primaryRedGradient,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: !logoutController.loading
                              ? ElevatedButton(
                                  onPressed: () {
                                    _logout();
                                    // _terminateSession();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  child: const Text(
                                    'OK',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 18,
                                    ),
                                  ),
                                )
                              : Center(
                                  child:
                                      LoadingAnimationWidget.staggeredDotsWave(
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )),
          );
        });
  }

  _showUpdateDrawer() {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            gradient: AppColor.primaryRedGradient,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          height: 600,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: links.map((link) {
                return GestureDetector(
                  onTap: () {
                    _navigationController.navigateToEditProfile();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(
                        14.0,
                      ),
                    ),
                    padding: const EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                    ),
                    child: Center(
                      child: GradientText(
                        text: link["name"]!,
                        textType: TextType.heading,
                        gradient: AppColor.yellowGradient,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
