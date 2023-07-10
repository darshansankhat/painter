import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:painter/painter/controller/painter_controller.dart';
import 'package:sizer/sizer.dart';

class PainterHome extends StatefulWidget {
  const PainterHome({Key? key}) : super(key: key);

  @override
  State<PainterHome> createState() => _PainterHomeState();
}

class _PainterHomeState extends State<PainterHome> {
  Drawingcontroller controller = Get.put(Drawingcontroller());
  GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                height: 6.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    colorPick(Colors.red),
                    colorPick(Colors.amber),
                    colorPick(Colors.pink),
                    colorPick(Colors.green),
                    colorPick(Colors.blue),
                    colorPick(Colors.lightGreen),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onPanStart: (details) {
                setState(() {
                  RenderBox? renderBox =
                      context.findRenderObject() as RenderBox?;
                  controller.points.add(Drawingmodal(
                      Paint()
                        ..color = controller.currentcolor.value
                        ..strokeCap = StrokeCap.round
                        ..strokeWidth = controller.slider.value
                        ..isAntiAlias = true,
                      renderBox!.globalToLocal(details.globalPosition)));
                });
              },
              onPanEnd: (details) {
                setState(() {
                  controller.points.add(Drawingmodal(Paint(), Offset.zero));
                });
              },
              onPanUpdate: (details) {
                setState(() {
                  RenderBox? renderBox =
                      context.findRenderObject() as RenderBox?;
                  controller.points.add(Drawingmodal(
                      Paint()
                        ..color = controller.currentcolor.value
                        ..strokeCap = StrokeCap.square
                        ..strokeWidth = controller.slider.value
                        ..isAntiAlias = true,
                      renderBox!.globalToLocal(details.globalPosition)));
                });
              },
              child: Container(
                width: 100.w,
                height: 72.h,
                child: CustomPaint(
                  painter: Customdrawing(controller.points),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            height: 12.h,
            width: 100.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.black12,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.brush),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.opacity),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.color_lens),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.camera),
                    ),
                    IconButton(
                      onPressed: () {
                        controller.points.clear();
                      },
                      icon: Icon(Icons.clear),
                    ),
                  ],
                ),
                Obx(
                  () => Slider(
                    value: controller.slider.value,
                    min: 0,
                    activeColor: controller.currentcolor.value,
                    inactiveColor: Colors.indigo.shade100,
                    max: 20,
                    onChanged: (value) {
                      controller.slider.value=value;
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell colorPick(Color c1) {
    return InkWell(
      onTap: () {
        controller.currentcolor.value=c1;
      },
      child: Container(
        height: 4.h,
        width: 10.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: c1,
        ),
      ),
    );
  }
}

class Drawingmodal {
  Paint paint;
  Offset offset;

  Drawingmodal(this.paint, this.offset);
}

class Customdrawing extends CustomPainter {
  List<Drawingmodal> pointsList;

  Customdrawing(this.pointsList);

  List<Offset> offlist = [];

  void clear() {
    pointsList.clear();
    offlist.clear();
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < (pointsList.length - 1); i++) {
      if (pointsList[i] != null && pointsList[i + 1] == null) {
        canvas.drawLine(pointsList[i].offset, pointsList[i + 1].offset,
            pointsList[i].paint);
      } else if (pointsList[i] != null && pointsList[i + 1] != null) {
        offlist.clear();
        offlist.add(pointsList[i].offset);
        offlist.add(Offset(
            pointsList[i].offset.dx + 0.1, pointsList[i].offset.dy + 0.1));
        canvas.drawPoints(PointMode.points, offlist, pointsList[i].paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
