import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
import 'package:crashorcash/utils/constants/app_color.dart';
import 'package:crashorcash/utils/helpers/user_token_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double toolbarHeight;
  final dynamic me;

  CustomAppBar({super.key, this.toolbarHeight = 80})
      : me = UserTokenManager().user;

  String _ellipsize(String text, {int maxLength = 10}) {
    if (text.length <= maxLength) {
      return text;
    }
    return '${text.substring(0, maxLength)}...';
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: toolbarHeight,
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
                      _ellipsize(me['_id']),
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
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
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 15.0),
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
      titleTextStyle: const TextStyle(color: AppColor.yellow),
      leading: Container(),
      leadingWidth: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(gradient: AppColor.appBarGradient),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
}
