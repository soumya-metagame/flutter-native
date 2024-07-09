import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    String? url = Get.parameters['url'] ?? '';
    return Scaffold(
      body: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(NavigationDelegate(
            onProgress: (int progress) {},
            onPageStarted: (String url) {
              print('URL IS: $url');
            },
            onPageFinished: (String url) {
              print('URL FINISHED: $url');
            },
            onUrlChange: (UrlChange change) {
              print('URL CHANGE: ${change.url}');

              if (change.url!
                  .startsWith('https://www.crashorcash.com/payment-success')) {
                var orderId = change.url!.split("=").last;
                Get.offNamed(
                  '/payment-success',
                  parameters: {"order_id": orderId},
                );
                NavigationDecision.prevent;
              }
            },
            onHttpError: (HttpResponseError error) {
              print('HTTP ERROR: $error');
            },
            onWebResourceError: (WebResourceError error) {
              print('WEB RESOURCE ERROR: $error');
            },
            onNavigationRequest: (NavigationRequest request) {
              if (request.url.startsWith('upi://pay?') ||
                  request.url.startsWith('phonepe://pay?') ||
                  request.url.startsWith('gpay://upi/pay?') ||
                  request.url.startsWith('paytmmp://pay?')) {
                _handleIntent(Uri.parse(request.url));
                return NavigationDecision.prevent;
              }
              if (request.url.startsWith('https://www.youtube.com/')) {
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ))
          ..loadRequest(Uri.parse(url)),
      ),
    );
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
