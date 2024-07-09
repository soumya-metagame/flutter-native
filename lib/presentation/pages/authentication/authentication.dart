import 'dart:io';

import 'package:crashorcash/data/datesources/remote/auth/verify-mobile.dart';
import 'package:crashorcash/data/datesources/remote/auth/verify-otp.dart';
import 'package:crashorcash/data/datesources/remote/player/fetch-loggedin-user.dart';
import 'package:crashorcash/data/datesources/remote/player/terminate-session.dart';
import 'package:crashorcash/domain/models/res/fetch-loggedin-user-res.dart';
import 'package:crashorcash/domain/models/res/send-otp-res.dart';
import 'package:crashorcash/domain/models/res/terminate-session-res.dart';
import 'package:crashorcash/domain/models/res/verify-otp-res.dart';
import 'package:crashorcash/navigation_menu.dart';
import 'package:crashorcash/presentation/pages/authentication/loading-controller.dart';
import 'package:crashorcash/utils/constants/app_color.dart';
import 'package:crashorcash/utils/helpers/user_token_manager.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:pinput/pinput.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:toastification/toastification.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => __AuthenticationPageState();
}

class __AuthenticationPageState extends State<Authentication> {
  UserTokenManager userTokenManager = UserTokenManager();

  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController otpController = TextEditingController();

  final OtpInputController otpInputController = Get.put(OtpInputController());

  final PhoneNumberInputController controller =
      Get.put(PhoneNumberInputController());

  late String _phoneNumber;
  late String _otp;

  bool _isPhoneNumberComplete = false;

  bool _isOtpSent = false;

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  Map<String, dynamic> _deviceData = <String, dynamic>{};

  final dio = Dio();
  // Controller for phone number TextField

  @override
  void initState() {
    super.initState();
    initPlatformState();

    print('Device id: $_deviceData');
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    phoneNumberController.dispose();

    super.dispose();
  }

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
      'serialNumber': build.serialNumber,
      'isLowRamDevice': build.isLowRamDevice,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  void _handlePhoneNumberChange(String text) {
    setState(() {
      _isPhoneNumberComplete = text.length == 10;

      if (_isPhoneNumberComplete) {
        FocusScope.of(context).unfocus();
      }
      _phoneNumber = text;
    });
  }

  Future<void> _terminateSession() async {
    setState(() {
      controller.isLoading(true);
    });

    try {
      final response = await terminateSession(_phoneNumber);

      if (response is TerminateSessionResponse) {
        if (response.code == 'PS407') {
          print('Response from the TERMINATE-SESSION: $response');

          await _verifyOTP();

          setState(() {
            controller.isLoading(false);
          });
        }
        // Get.toNamed(page)
      }
    } catch (error) {
      setState(() {
        controller.setLoading(false);
      });
      print(error);
    }
  }

  Future<void> _verifyPhoneNumber() async {
    setState(() {
      controller.isLoading(true);
    });

    try {
      final response = await initiateVerification(_phoneNumber);

      if (response is InitiateVerificationResponse && response.code == "L200") {
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
        print('Response from the SEND-OTP: $response');

        setState(() {
          controller.isLoading(false);
          _isOtpSent = true;
        });

        print('IS_OTP_SENT: $_isOtpSent');
        // Get.toNamed(page)
      } else {
        print('IS_OTP_SENT: $_isOtpSent');
        print('Response from the SEND-OTP: $response');
      }
    } catch (error) {
      setState(() {
        controller.setLoading(false);
      });
      print(error);
    }
  }

  Future<void> _verifyOTP() async {
    setState(() {
      otpInputController.isLoading(true);
    });

    try {
      print('DEVICE: $_deviceData');

      final response = await verifyOtp(_phoneNumber, _otp, _deviceData['id']);

      if (response is VerifyOTPResponse && response.code == 'L200') {
        print('Response from the VERIFY-OTP: $response');

        setState(() {
          otpInputController.isLoading(false);
        });

        final accessToken = response.data?['token'];

        userTokenManager.setToken(accessToken: accessToken);

        final fetchUserResponse = await fetchLoggedinUser();

        if (fetchUserResponse is FetchLoggedInUserResponse &&
            fetchUserResponse.code == 'CU200') {
          // print('Response from the FETCH-LOGGEDIN-USER: $fetchUserResponse');
          // print(fetchUserResponse.data);
          userTokenManager.setUserData(fetchUserResponse.data!);
          Get.to(() => const NavigationMenu());
        } else {
          print('Response from the FETCH-LOGGEDIN-USER: $fetchUserResponse');
        }
      } else if (response is VerifyOTPResponse && response.code == 'PS405') {
        _showTerminateSessionDrawer();
      }
    } catch (error) {
      setState(() {
        controller.setLoading(false);
      });
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    final defaultPinTheme = PinTheme(
        width: 36,
        height: 36,
        textStyle: const TextStyle(fontSize: 18, color: Colors.black),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: AppColor.tacao, width: 1)));

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/auth-portrait-bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 100,
              left: MediaQuery.of(context).size.width / 2 - 154,
              child: Image.asset(
                'assets/images/full-size-char-2.png',
                height: 360,
                scale: 1.5,
              ),
            ),
            Positioned(
              top: 450 - keyboardHeight / 2,
              left: MediaQuery.of(context).size.width * 0.05,
              right: MediaQuery.of(context).size.width * 0.05,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 280,
                    padding: const EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                      gradient: AppColor.yellowGradient,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: AppColor.primaryRedGradient,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: MediaQuery.of(context).size.width * 0.95 - 2,
                      height: 280 - 2,
                      child: Container(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ShaderMask(
                              shaderCallback: (bounds) {
                                return AppColor.yellowGradient.createShader(
                                    Rect.fromLTWH(
                                        0, 0, bounds.width, bounds.height));
                              },
                              child: const Text(
                                "Signup / Login",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (_isOtpSent)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Pinput(
                                    length: 6,
                                    controller: otpController,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    defaultPinTheme: defaultPinTheme,
                                    onCompleted: (value) {
                                      setState(() {
                                        _otp = value;
                                      });
                                    },
                                    focusedPinTheme: defaultPinTheme.copyWith(
                                        decoration: defaultPinTheme.decoration!
                                            .copyWith(
                                                border: Border.all(
                                                    color: AppColor.sunglow,
                                                    width: 2))),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    child: const Text(
                                      'RESEND OTP',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: AppColor.sunglow,
                                          decoration: TextDecoration.underline,
                                          decorationColor: AppColor.sunglow),
                                    ),
                                  ),
                                ],
                              )
                            else
                              Center(
                                child: Container(
                                    padding: const EdgeInsets.all(2),
                                    height: 40,
                                    width: 250,
                                    decoration: BoxDecoration(
                                        gradient: AppColor.yellowGradient,
                                        borderRadius:
                                            BorderRadius.circular(14)),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        // boxShadow: const [
                                        //   BoxShadow(
                                        //     color: Color.fromARGB(123, 255, 196, 0),
                                        //     blurRadius: 1,
                                        //     spreadRadius: 1,
                                        //     offset: Offset(-2, 2),
                                        //   )
                                        // ],
                                      ),
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 0),
                                      child: Row(
                                        children: <Widget>[
                                          Wrap(
                                            spacing: 6,
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                'assets/images/flag.png',
                                                height: 18,
                                              ),
                                              const Text(
                                                "+91",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              )
                                            ],
                                          ),
                                          const VerticalDivider(
                                            width: 20,
                                            indent: 8,
                                            endIndent: 8,
                                            thickness: 1,
                                            color: Colors.black,
                                          ),
                                          Expanded(
                                            child: TextField(
                                              keyboardType: TextInputType.phone,
                                              onChanged: (text) {
                                                _handlePhoneNumberChange(text);
                                              },
                                              controller: phoneNumberController,
                                              // controller:
                                              //     phoneNumberController, // Assign the controller here
                                              textAlign: TextAlign.center,
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    10)
                                              ],
                                              decoration: const InputDecoration(
                                                hintText: "8917XXXX78",
                                                border: InputBorder.none,
                                                hintStyle: TextStyle(
                                                  color: Colors.black45,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 10),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            const SizedBox(height: 30),
                            Container(
                              height: 40,
                              width: 220,
                              padding: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                gradient: AppColor.yellowGradient,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: AppColor.primaryGreenGradient,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ElevatedButton(
                                  onPressed: _isOtpSent
                                      ? _verifyOTP
                                      : _verifyPhoneNumber,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  child: Obx(() {
                                    return !_isOtpSent &&
                                            !controller.isLoading.value
                                        ? const Text(
                                            'Signup / Login',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          )
                                        : !_isOtpSent &&
                                                controller.isLoading.value
                                            ? Center(
                                                child: LoadingAnimationWidget
                                                    .staggeredDotsWave(
                                                  color: Colors.white,
                                                  size: 28,
                                                ),
                                              )
                                            : _isOtpSent &&
                                                    !otpInputController
                                                        .isLoading.value
                                                ? const Text(
                                                    'Verify',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                    ),
                                                  )
                                                : Center(
                                                    child:
                                                        LoadingAnimationWidget
                                                            .staggeredDotsWave(
                                                      color: Colors.white,
                                                      size: 28,
                                                    ),
                                                  );
                                  }),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text:
                                      'By Logging in you are Accept that you are 18+ and Agree to our ',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'T&C ',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.yellow)),
                                    TextSpan(
                                        text: 'And ',
                                        style: GoogleFonts.montserrat()),
                                    TextSpan(
                                        text: 'Privacy Policy',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.yellow))
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showTerminateSessionDrawer() {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            decoration: const BoxDecoration(
              gradient: AppColor.primaryRedGradient,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(26.0),
                topRight: Radius.circular(26.0),
              ),
            ),
            height: 600,
            child: Center(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(
                10.0,
                20.0,
                10.0,
                20.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  GradientText(
                    'TERMINATE SESSION',
                    colors: const [Color(0xFFFBC104), Color(0xFFFFFF96)],
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  Image.asset(
                    'assets/images/notification.png',
                    height: 100,
                  ),
                  const Text(
                    "You've already logged onto another\ndevice. click ok to terminate the\nother session and continue with the \ncurrent session",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
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
                          child: ElevatedButton(
                            onPressed: () async {
                              _terminateSession();
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
}
