import 'package:crashorcash/layout.dart';
import 'package:crashorcash/presentation/controllers/games/games_controller.dart';
import 'package:crashorcash/utils/constants/app_color.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Games extends GetView<GamesController> {
  const Games({super.key});

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
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
          child: Column(
            children: [
              Image.asset(
                'assets/images/GameIcon_L.png',
                scale: 1.5,
              ),
              Expanded(
                child: Obx(() {
                  return Skeletonizer(
                    enabled: controller.games.isEmpty,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 6.0,
                        mainAxisSpacing: 6.0,
                        childAspectRatio: .7,
                      ),
                      itemCount: controller.games.length,
                      itemBuilder: (context, index) {
                        final game = controller.games[index];

                        return FutureBuilder(
                          future: controller.getImageInfo(game.icon),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return const Center(child: Icon(Icons.error));
                            } else if (snapshot.hasData) {
                              final imageInfo = snapshot.data!;
                              final isBase64 = imageInfo['isBase64'] as bool;
                              final imageData = imageInfo['imageData'];
                              final gameId = game.id;
                              final gameName = game.gameName;

                              return GestureDetector(
                                onTap: () {
                                  Get.toNamed('/games/$gameId', parameters: {
                                    'gameName': gameName,
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(microseconds: 200),
                                  height: 100,
                                  padding: const EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                    gradient: AppColor.yellowGradient,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: isBase64
                                        ? Image.memory(
                                            imageData,
                                            fit: BoxFit.fitHeight,
                                            height: 20.0,
                                            scale: 1.5,
                                          )
                                        : Image.network(
                                            game.icon,
                                            fit: BoxFit.fitHeight,
                                            height: 20.0,
                                            scale: 1.5,
                                          ),
                                  ),
                                ),
                              );
                            } else {
                              return const Center(
                                  child: Icon(Icons.image_not_supported));
                            }
                          },
                        );
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class Games extends StatefulWidget {
//   const Games({super.key});

//   @override
//   GamesState createState() => GamesState();
// }

// class GamesState extends State<Games> {
//   late List<GameModel> games = [];

//   final navigationController = Get.put(NavigationController);

//   @override
//   void initState() {
//     super.initState();
//     // _preloadImage();
//     _fetchGameList();
//   }

//   Future<void> _fetchGameList() async {
//     try {
//       final response = await fetchGameList();

//       if (response is GameListResponseModel && response.code == 'G200') {
//         setState(() {
//           games = response.data.games;
//         });

//         for (var game in games) {
//           await processGameIcon(game.icon);
//         }
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<void> processGameIcon(String iconUrl) async {
//     final dio = Dio();

//     final imageName = iconUrl.split('/').last.split('.').first;

//     if (ImageManager().containsImage(imageName)) {
//       print('Image already exists in the database');
//       return;
//     }

//     try {
//       final response = await dio.get(
//         iconUrl,
//         options: Options(responseType: ResponseType.bytes),
//       );

//       if (response.statusCode == 200) {
//         final bytes = response.data;

//         final base64Image = base64Encode(bytes);

//         await ImageManager.instance
//             .addImage(imageName: imageName, base64: base64Image);
//       } else {
//         throw Exception('Failed to load image');
//       }
//     } catch (e) {
//       print('Error fetching image: $e');
//     }
//   }

//   Future<Map<String, dynamic>> getImageInfo(String iconUrl) async {
//     final imageName = iconUrl.split('/').last.split('.').first;

//     dynamic base64Image = ImageManager.instance.getImage(imageName);

//     if (base64Image == null) {
//       return {'isBase64': false, 'imageData': iconUrl};
//     }

//     Uint8List bytes = base64Decode(base64Image);

//     return {'isBase64': true, 'imageData': bytes};
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage("assets/images/lobby-blurred-bg.png"),
//               fit: BoxFit.cover),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
//           child: Column(
//             children: [
//               Image.asset(
//                 'assets/images/GameIcon_L.png',
//                 // height: 360,
//                 scale: 1.5,
//               ),
//               Expanded(
//                 child: games.isEmpty
//                     ? const Center(
//                         child: CircularProgressIndicator(),
//                       )
//                     : GridView.builder(
//                         gridDelegate:
//                             const SliverGridDelegateWithFixedCrossAxisCount(
//                                 crossAxisCount: 3,
//                                 crossAxisSpacing: 6.0,
//                                 mainAxisSpacing: 6.0,
//                                 childAspectRatio: .7),
//                         itemCount: games.length,
//                         itemBuilder: (context, index) {
//                           final game = games[index];

//                           return FutureBuilder(
//                             future: getImageInfo(game.icon),
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState ==
//                                   ConnectionState.waiting) {
//                                 return const Center(
//                                     child: CircularProgressIndicator());
//                               } else if (snapshot.hasError) {
//                                 return const Center(child: Icon(Icons.error));
//                               } else if (snapshot.hasData) {
//                                 final imageInfo = snapshot.data!;
//                                 final isBase64 = imageInfo['isBase64'] as bool;
//                                 final imageData = imageInfo['imageData'];
//                                 final gameId = game.id;

//                                 return GestureDetector(
//                                   onTap: () {
//                                     Get.toNamed('/games/$gameId');
//                                   },
//                                   child: AnimatedContainer(
//                                       duration:
//                                           const Duration(microseconds: 200),
//                                       height: 100,
//                                       padding: const EdgeInsets.all(2.0),
//                                       decoration: BoxDecoration(
//                                           gradient: AppColor.yellowGradient,
//                                           borderRadius:
//                                               BorderRadius.circular(10.0)),
//                                       child: ClipRRect(
//                                         borderRadius:
//                                             BorderRadius.circular(8.0),
//                                         child: isBase64
//                                             ? Image.memory(
//                                                 imageData,
//                                                 fit: BoxFit.fitHeight,
//                                                 height: 20.0,
//                                                 scale: 1.5,
//                                               )
//                                             : Image.network(
//                                                 game.icon,
//                                                 fit: BoxFit.fitHeight,
//                                                 height: 20.0,
//                                                 scale: 1.5,
//                                               ),
//                                       )),
//                                 );
//                               } else {
//                                 // Return a default widget in case there's no data or an unexpected case
//                                 return const Center(
//                                     child: Icon(Icons.image_not_supported));
//                               }
//                             },
//                           );
//                         },
//                       ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
