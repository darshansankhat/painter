import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:painter/painter/view/painter_homescreen.dart';
import 'package:painter/painter/view/splash_screen.dart';
import 'package:sizer/sizer.dart';

void main()
{
  runApp(
    Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "splash",
        routes: {
          "/":(context) => PainterHome(),
          "splash":(context) => SplashScreen(),
        },
      ),
    ),
  );
}