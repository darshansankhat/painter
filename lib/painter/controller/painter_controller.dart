import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/painter_homescreen.dart';

class Drawingcontroller extends GetxController {
  // var pickcolor = Color(0xff000000).obs;
  RxDouble slider=0.0.obs;
  var currentcolor = Color(0xff000000).obs;
  RxList<Drawingmodal> points = <Drawingmodal>[].obs;
}