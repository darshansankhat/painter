import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(seconds: 5),() {
      Get.offAndToNamed("/");
    },);

    return SafeArea(child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Painter",style: TextStyle(fontSize: 25,color: Colors.amber),),
            SizedBox(height: 20,),
            CircularProgressIndicator(backgroundColor: Colors.amber.shade100,color: Colors.amber,)
          ],
        ),
      ),
    ),);
  }
}
