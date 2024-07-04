import 'package:hive_flutter/hive_flutter.dart';

class ImageManager {
  static ImageManager _instance = ImageManager();

  static ImageManager get instance {
    _instance ??= ImageManager();

    return _instance;
  }

  Box get _db {
    return Hive.box("images");
  }

  Future<void> addImage(
      {required String imageName, required String base64}) async {
    Map<dynamic, dynamic> imageMap = _db.get('remoteImages', defaultValue: {});
    imageMap[imageName] = base64;
    await _db.put('remoteImages', imageMap);
  }

  Future<void> removeImage(String imageName) async {
    Map<String, String> imageMap = _db.get('remoteImages', defaultValue: {});
    imageMap.remove(imageName);
    await _db.put('remoteImages', imageMap);
  }

  String? getImage(String imageName) {
    Map<dynamic, dynamic> imageMap = _db.get(
      'remoteImages',
    );
    return imageMap[imageName];
  }

  Future<void> clearImages() async {
    await _db.delete('remoteImages');
  }

  bool containsImage(String imageName) {
    return _db.containsKey(imageName);
  }
}
