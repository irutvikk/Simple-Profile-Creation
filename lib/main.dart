import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simpleprofilecreation/Providers/todosprovider.dart';
import 'package:simpleprofilecreation/Screens/homescreen.dart';
import 'Providers/homescreenprovider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp,]);
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => TodosProvider(),
            ),
            ChangeNotifierProvider(
              create: (context) => HomescreenProvider(),
            ),
          ],
          child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Homepage()
            // home: Homepage()
          ),
        );
      },
    ),
  );
}