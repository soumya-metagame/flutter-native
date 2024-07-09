import 'package:crashorcash/data/datesources/remote/games/fetch_game_launchurl_api.dart';
import 'package:crashorcash/domain/models/res/fetch_game_launchUrl_res.dart';
import 'package:crashorcash/layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GameDetails extends StatefulWidget {
  const GameDetails({super.key});

  @override
  State<GameDetails> createState() => _GameDetailsState();
}

class _GameDetailsState extends State<GameDetails> {
  String link = '';
  String gameId = Get.parameters['gameId'] ?? '';
  String gameName = Get.parameters['gameName'] ?? '';
  bool isUrlLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchGameLaunchUrl();
  }

  Future<void> _fetchGameLaunchUrl() async {
    setState(() {
      isUrlLoading = true;
    });
    try {
      final response = await fetchGameLaunchUrl(gameId);

      if (response is FetchGameLaunchUrlResponse && response.code == 'G201') {
        link = response.launchUrl;
        print("LINK: $link");
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isUrlLoading = false;
      });
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
        child: link == '' && isUrlLoading
            ? const Center(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/lobby-blurred-bg.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: WebViewWidget(
                  controller: WebViewController()
                    ..setJavaScriptMode(JavaScriptMode.unrestricted)
                    ..setNavigationDelegate(NavigationDelegate(
                        onProgress: (int progress) {},
                        onPageStarted: (String url) {
                          print("PAGE STARTED: $url");
                        },
                        onPageFinished: (String url) {
                          print("PAGE FINISHED: $url");
                        },
                        onHttpError: (HttpResponseError error) {
                          print("HTTP ERROR: $error");
                        },
                        onNavigationRequest: (NavigationRequest request) {
                          if (request.url
                              .startsWith('https://www.youtube.com/')) {
                            return NavigationDecision.prevent;
                          }
                          return NavigationDecision.navigate;
                        }))
                    ..loadRequest(
                      Uri.parse(link),
                    ),
                ),
              ),
      ),
    );
  }
}
