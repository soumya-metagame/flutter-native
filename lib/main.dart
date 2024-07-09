import 'package:crashorcash/config/router/routes.dart';
import 'package:crashorcash/presentation/controllers/layout/navigation_controller.dart';
import 'package:crashorcash/utils/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("user");
  await Hive.openBox("images");

  var initialRoute = "/";

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Get.put(NavigationController());

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: GetMaterialApp(
        title: 'CrashORCash',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.montserratTextTheme(),
          fontFamily: 'Montserrat',
          scaffoldBackgroundColor: AppColor.falu_red_2,
          useMaterial3: true,
        ),
        initialRoute: initialRoute,
        getPages: Routes.routes,
        // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
