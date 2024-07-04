import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    String? orderId = Get.parameters['order_id'] ?? '';
    return Scaffold(
        body: Center(
      child: Text(orderId),
    ));
  }

  void _handleIntent(Uri url) async {
    // Launch the intent using url_launcher
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
