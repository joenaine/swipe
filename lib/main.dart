import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:swifeeapp/constants/app_colors_const.dart';
import 'package:swifeeapp/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.dark,
        primaryTextTheme:
            const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}
