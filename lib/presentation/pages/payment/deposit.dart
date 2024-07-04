import 'package:crashorcash/presentation/controllers/payment/deposit_controller.dart';
import 'package:crashorcash/utils/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Deposit extends StatefulWidget {
  const Deposit({super.key});

  @override
  State<Deposit> createState() => _DepositState();
}

class _DepositState extends State<Deposit> {
  List<String> amounts = ["2", "100", "300", "1500", "3000", "6000"];
  String selectedAmount = "2";

  DepositController depositController = DepositController();

  Future<void> _deposit() async {
    final response = await depositController.createDeposit(selectedAmount);

    if (response.data?.url != '') {
      // Get.offNamed(
      //   '/payment',
      //   parameters: {"url": response.data!.url},
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                height: MediaQuery.of(context).size.height - 200,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) {
                          return AppColor.yellowGradient.createShader(
                              Rect.fromLTWH(0, 0, bounds.width, bounds.height));
                        },
                        child: Text(
                          'DEPOSIT',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 26.0,
                              fontWeight: FontWeight.w600,
                              shadows: [
                                const Shadow(
                                    color: AppColor.amber,
                                    blurRadius: 4.0,
                                    offset: Offset(1, 0))
                              ]),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 6.0,
                            childAspectRatio: 1.2,
                            mainAxisSpacing: 6.0,
                          ),
                          itemCount: amounts.length,
                          itemBuilder: (context, index) {
                            String amount = amounts[index];

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedAmount = amount;
                                });
                              },
                              child: Card(
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  height: 70,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: amount == selectedAmount
                                        ? Border.all(
                                            width: 3,
                                            color: AppColor.yellow,
                                          )
                                        : Border.all(width: 0),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.4),
                                        offset: const Offset(-4, 6),
                                        blurRadius: 8.0,
                                        spreadRadius: 2.0,
                                      )
                                    ],
                                    gradient: AppColor.greenGradient,
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        bottom: 0,
                                        top: 0,
                                        left: -56,
                                        child: Image.asset(
                                          "assets/images/cash.png",
                                          height: 100,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        left: 10,
                                        child: Image.asset(
                                          "assets/images/coins.png",
                                          height: 70,
                                        ),
                                      ),
                                      Positioned(
                                        right: 18,
                                        top: 16,
                                        child: Text(
                                          '\u{20B9} $amount',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 28.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _deposit();
                        },
                        child: Container(
                            height: 60,
                            padding: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              gradient: AppColor.yellowGradient,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(9.0),
                                gradient: AppColor.primaryRedGradient,
                              ),
                              child: Center(
                                child: !depositController.loading
                                    ? Text(
                                        "Add Money",
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      )
                                    : LoadingAnimationWidget.staggeredDotsWave(
                                        color: Colors.white,
                                        size: 28,
                                      ),
                              ),
                            )
                            // child: ElevatedButton(
                            //   onPressed: () {},
                            //   style: ElevatedButton.styleFrom(
                            //     backgroundColor: Colors.transparent,
                            //     shadowColor: Colors.transparent,
                            //   ),
                            //   child: Obx(() {
                            //     return const Text(
                            //       'Add Money',
                            //       style: TextStyle(
                            //         color: Colors.white,
                            //         fontSize: 18,
                            //       ),
                            //     );
                            //   }),
                            // ),
                            ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
