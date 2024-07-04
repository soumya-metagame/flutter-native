import 'package:flutter/material.dart';

class AppColor {
  // YELLOW
  static const Color tacao = Color(0xFFEEB775);
  static const Color apline = Color(0xFFB88624);
  static const Color sunglow = Color(0xFFFED12C);
  static const Color bianca = Color(0xFFFFFCF1);
  static const Color amber = Color(0xFFFFC200);
  static const Color yellow = Color(0xFFFFE177);
  static const Color text_yellow = Color(0xFFCCAC47);

  // RED
  static const Color jasper = Color(0xFFCE4242);
  static const Color falu_red = Color(0xFF831616);
  static const Color falu_red_2 = Color(0xFF881515);
  static const Color carmine_pink = Color(0xFFF04545);
  static const Color red_berry = Color(0xFF8D0000);
  static const Color dried_blood = Color(0xFF460000);

  // GREEN
  static const Color india_green = Color(0xFF128200);
  static const Color palm_leaf = Color(0xFF699F3F);
  static const Color deep_green = Color(0xFF007413);
  static const Color emerald_green = Color(0xFF02600F);
  static const Color verse_green = Color(0xFF0B7F18);
  static const Color green = Color(0xFF52AB38);
  static const Color green_1 = Color(0xFF3db850);
  static const Color green_2 = Color(0xFF0e9548);

  //BLUE
  static const Color blue = Color(0xFF0c51a2);
  static const Color blue_1 = Color(0xFF146fb7);
  static const Color blue_2 = Color(0xFF185288);
  static const Color blue_3 = Color(0xFF0c57a3);
  static const Color blue_4 = Color(0xFF449fd8);

  //BROWN
  static const Color brown = Color(0xFF431000);
  static const Color brown_1 = Color(0xFF4e1604);
  static const Color brown_2 = Color(0xFF280a01);
  static const Color brown_3 = Color(0xFF520828);
  static const Color brown_4 = Color(0xFF533326);
  static const Color brown_5 = Color(0xFF251e10);
  static const Color brown_6 = Color(0xFF24100a);

  //PURPLE
  static const Color purple_1 = Color(0xFF411959);
  static const Color purple_2 = Color(0xFF8b35bf);

  static const LinearGradient yellowGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [tacao, apline, sunglow, bianca, amber],
    // stops: [8.12, 31.05, 53.98, 76.91, 99.84]
  );

  static const LinearGradient greenGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [green_1, green_2]);

  static const RadialGradient yellowRadialGradient = RadialGradient(
      center: FractionalOffset(0.516, 0.6062),
      radius: 0.3438,
      colors: [
        Color.fromRGBO(255, 138, 0, 0.53),
        Color.fromRGBO(255, 138, 0, 0)
      ],
      stops: [
        0.0,
        1.0
      ]);

  static const LinearGradient purpleGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [purple_1, purple_2],
    stops: [0.59, 1.0],
  );

  static const LinearGradient primaryRedGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [red_berry, dried_blood],
    // stops: [
    //   -0.301, // -3.01%
    //   0.417, // 41.9%
    //   0.8389, // 83.89%
    //   1.0897, // 108.97%
    // ],
  );

  static const LinearGradient primaryBlueGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [blue, blue_1, blue_2, blue_3, blue_4]);

  static const LinearGradient appBarGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.black, Color(0xFF4A1403)],
    stops: [0.7, 1.0],
  );

  static const LinearGradient primaryBrownGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [brown, brown_1, brown_2]);

  static const LinearGradient bottomNavBarGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [brown_4, brown_5, brown_6],
    stops: [0.18, 0.95, 1.0],
  );

  static const LinearGradient primaryGreenGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        india_green,
        palm_leaf,
        deep_green,
        emerald_green,
        verse_green,
        green
      ]);
}
