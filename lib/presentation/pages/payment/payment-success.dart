import 'dart:async';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:crashorcash/presentation/controllers/payment/fetch_transaction_by_orderId_controller.dart';
import 'package:crashorcash/presentation/widgets/gradient-text.dart';
import 'package:crashorcash/utils/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentSuccess extends StatefulWidget {
  const PaymentSuccess({super.key});

  @override
  State<PaymentSuccess> createState() => _PaymentSuccessState();
}

class _PaymentSuccessState extends State<PaymentSuccess> {
  final int _duration = 30;
  final CountDownController _countDownController = CountDownController();
  String? orderId = Get.parameters['order_id'] ?? '';
  final _fetchTransactionByOrderidController =
      FetchTransactionByOrderidController();

  Map<String, dynamic> transaction = {};

  bool _copiedToClipBoard = false;

  Timer? _timer;

  bool fetchedTransaction = false;

  @override
  void initState() {
    super.initState();
    startFetchingTransaction();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startFetchingTransaction() {
    const interval = Duration(seconds: 5);
    const totalDuration = Duration(seconds: 30);

    final int numberOfCalls = totalDuration.inSeconds ~/ interval.inSeconds;

    int callCount = 0;

    _timer = Timer.periodic(interval, (Timer timer) async {
      if (callCount < numberOfCalls) {
        final response = await _fetchTransactionByOrderidController
            .fetchTransaction(orderId!);
        if (response.code == 'EX200') {
          setState(() {
            transaction = response.data;
            fetchedTransaction = true;
          });
          timer.cancel();
          _countDownController.pause();
        }
        callCount++;
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.black,
        title: ShaderMask(
          shaderCallback: (bounds) {
            return AppColor.yellowGradient
                .createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height));
          },
          // child: Text(
          //   gameName.toUpperCase(),
          //   style: const TextStyle(
          //     letterSpacing: 1.3,
          //   ),
          // ),
        ),
        titleTextStyle: const TextStyle(
          // color: AppColor.yellow,
          fontSize: 22.0,
          fontWeight: FontWeight.bold,
        ),
        // leading: Container(),
        // leadingWidth: 0,
        centerTitle: true,
        foregroundColor: AppColor.text_yellow,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColor.appBarGradient,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/lobby-blurred-bg.png"),
          fit: BoxFit.cover,
        )),
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
                height: 540,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const GradientText(
                        text: "TRANSACTION DETAILS",
                        textType: TextType.heading,
                        gradient: AppColor.yellowGradient,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (!fetchedTransaction) ...[
                        CircularCountDownTimer(
                          width: 100,
                          height: 100,
                          duration: _duration,
                          controller: _countDownController,
                          fillColor: Colors.white,
                          fillGradient: AppColor.yellowGradient,
                          strokeWidth: 6,
                          strokeCap: StrokeCap.round,
                          autoStart: true,
                          isReverse: true,
                          // isReverseAnimation: true,
                          textStyle: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          ringColor: Colors.white,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GradientText(
                          text: orderId!,
                          textType: TextType.subtitle,
                          gradient: AppColor.yellowGradient,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const GradientText(
                          text: "Payment is processing",
                          textType: TextType.normal,
                          gradient: AppColor.yellowGradient,
                        ),
                      ] else if (fetchedTransaction &&
                          transaction['isTransactionSuccess']) ...[
                        const SizedBox(
                          height: 20,
                        ),
                        GradientText(
                          text: transaction['amount'].toString(),
                          customTextStyle: GoogleFonts.montserrat(
                            fontSize: 36,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                          gradient: AppColor.yellowGradient,
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        GradientText(
                          text: transaction['details']['orderId'],
                          textType: TextType.normal,
                          gradient: AppColor.yellowGradient,
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        const GradientText(
                          text: "Payment Success",
                          textType: TextType.subtitle,
                          gradient: AppColor.yellowGradient,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                const GradientText(
                                  text: "Transaction ID",
                                  textType: TextType.subtitle,
                                  gradient: AppColor.yellowGradient,
                                ),
                                GradientText(
                                  text: transaction["details"]
                                      ["paymentTransactionId"],
                                  textType: TextType.normal,
                                  gradient: AppColor.yellowGradient,
                                ),
                              ],
                            ),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 150),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                              child: _copiedToClipBoard
                                  ? const Icon(
                                      Icons.done,
                                      color: Colors.white,
                                      key: ValueKey('done'),
                                    )
                                  : GestureDetector(
                                      onTap: () async {
                                        await Clipboard.setData(
                                          ClipboardData(
                                            text: transaction["details"][
                                                "paymentTransactionId"], // Replace with your actual data
                                          ),
                                        );
                                        setState(() {
                                          _copiedToClipBoard = true;
                                        });

                                        Timer(const Duration(seconds: 3), () {
                                          setState(() {
                                            _copiedToClipBoard = false;
                                          });
                                        });
                                      },
                                      child: const Icon(
                                        Icons.content_copy,
                                        color: Colors.white,
                                        key: ValueKey('copy'),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                const GradientText(
                                  text: "Transaction Date",
                                  textType: TextType.subtitle,
                                  gradient: AppColor.yellowGradient,
                                ),
                                GradientText(
                                  text: DateTime.parse(transaction['createdAt'])
                                      .toLocal()
                                      .toString(),
                                  textType: TextType.normal,
                                  gradient: AppColor.yellowGradient,
                                ),
                              ],
                            ),
                          ],
                        )
                      ] else ...[
                        const SizedBox(
                          height: 20,
                        ),
                        GradientText(
                          text: orderId!,
                          textType: TextType.subtitle,
                          gradient: AppColor.yellowGradient,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const GradientText(
                          text: "Payment is processing",
                          textType: TextType.normal,
                          gradient: AppColor.yellowGradient,
                        ),
                      ]
                      // Image.asset(
                      //   "assets/images/success.gif",
                      //   height: 60,
                      // )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
