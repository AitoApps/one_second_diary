import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:one_second_diary/core_temp.dart';
import 'package:one_second_diary/home_screen.dart';
import 'package:one_second_diary/intro_screen.dart';
import 'package:permission_handler/permission_handler.dart';

import 'bindings/home_binding.dart';
import 'lang/translation_service.dart';
import 'routes/app_pages.dart';
import 'utils/shared_preferences_util.dart';

List<CameraDescription> cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //! PROD APP
  await StorageUtil.getInstance();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });

  // //! TEST AREA
  // cameras = await availableCameras();
  // runApp(MaterialApp(home: CoreTemp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),
      getPages: AppPages.pages,
      initialBinding: HomeBinding(),
      initialRoute: StorageUtil.getBool('showIntro') == false
          ? Routes.HOME
          : Routes.INTRO,
      debugShowCheckedModeBanner: false,
      title: 'One Second Diary',
      themeMode: ThemeMode.light,
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: Color(0xffff6366)),
        fontFamily: 'Magic',
        primaryColor: Color(0xffff6366),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
