import 'package:flutter/material.dart';

class Gramophone extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path path = Path();

    // Path number 1

    paint.color = Colors.cyan;
    path = Path();
    path.lineTo(size.width, size.height / 2);
    path.cubicTo(size.width, size.height * 0.22, size.width * 0.78, 0,
        size.width / 2, 0);
    path.cubicTo(
        size.width * 0.22, 0, 0, size.height * 0.22, 0, size.height / 2);
    path.cubicTo(0, size.height * 0.78, size.width * 0.22, size.height,
        size.width / 2, size.height);
    path.cubicTo(size.width * 0.78, size.height, size.width, size.height * 0.78,
        size.width, size.height / 2);
    path.cubicTo(size.width, size.height / 2, size.width, size.height / 2,
        size.width, size.height / 2);
    canvas.drawPath(path, paint);

    // Path number 2

    paint.color = Color(0xff292929);
    path = Path();
    path.lineTo(size.width * 0.69, size.height * 0.64);
    path.cubicTo(size.width * 0.69, size.height * 0.64, size.width * 0.71,
        size.height * 0.62, size.width * 0.71, size.height * 0.54);
    path.cubicTo(size.width * 0.71, size.height * 0.54, size.width * 0.71,
        size.height * 0.49, size.width * 0.72, size.height * 0.48);
    path.cubicTo(size.width * 0.73, size.height * 0.48, size.width * 0.75,
        size.height * 0.48, size.width * 0.75, size.height / 2);
    path.cubicTo(size.width * 0.75, size.height * 0.51, size.width * 0.74,
        size.height * 0.51, size.width * 0.73, size.height / 2);
    path.cubicTo(size.width * 0.73, size.height / 2, size.width * 0.73,
        size.height * 0.49, size.width * 0.73, size.height * 0.51);
    path.cubicTo(size.width * 0.73, size.height * 0.51, size.width * 0.74,
        size.height * 0.62, size.width * 0.72, size.height * 0.66);
    path.cubicTo(size.width * 0.72, size.height * 0.66, size.width * 0.69,
        size.height * 0.64, size.width * 0.69, size.height * 0.64);
    path.cubicTo(size.width * 0.69, size.height * 0.64, size.width * 0.69,
        size.height * 0.64, size.width * 0.69, size.height * 0.64);
    canvas.drawPath(path, paint);

    // Path number 3

    // paint.color = Color(0xffd4d4d4);
    // path = Path();
    // path.lineTo(size.width * 0.74, size.height * 0.8);
    // path.cubicTo(size.width * 0.74, size.height * 0.8, size.width * 0.72,
    //     size.height * 0.79, size.width * 0.72, size.height * 0.79);
    // path.cubicTo(size.width * 0.72, size.height * 0.79, size.width * 0.71,
    //     size.height * 0.79, size.width * 0.71, size.height * 0.79);
    // path.cubicTo(size.width * 0.71, size.height * 0.78, size.width * 0.71,
    //     size.height * 0.74, size.width * 0.71, size.height * 0.74);
    // path.cubicTo(size.width * 0.71, size.height * 0.74, size.width * 0.71,
    //     size.height * 0.74, size.width * 0.71, size.height * 0.73);
    // path.cubicTo(size.width * 0.7, size.height * 0.73, size.width * 0.68,
    //     size.height * 0.72, size.width * 0.68, size.height * 0.72);
    // path.cubicTo(size.width * 0.68, size.height * 0.72, size.width * 0.67,
    //     size.height * 0.72, size.width * 0.67, size.height * 0.73);
    // path.cubicTo(size.width * 0.67, size.height * 0.73, size.width * 0.67,
    //     size.height * 0.73, size.width * 0.68, size.height * 0.73);
    // path.cubicTo(size.width * 0.68, size.height * 0.73, size.width * 0.7,
    //     size.height * 0.74, size.width * 0.7, size.height * 0.74);
    // path.cubicTo(size.width * 0.7, size.height * 0.74, size.width * 0.7,
    //     size.height * 0.74, size.width * 0.7, size.height * 0.75);
    // path.cubicTo(size.width * 0.7, size.height * 0.75, size.width * 0.7,
    //     size.height * 0.79, size.width * 0.7, size.height * 0.79);
    // path.cubicTo(size.width * 0.7, size.height * 0.79, size.width * 0.7,
    //     size.height * 0.8, size.width * 0.71, size.height * 0.8);
    // path.cubicTo(size.width * 0.71, size.height * 0.8, size.width * 0.74,
    //     size.height * 0.81, size.width * 0.74, size.height * 0.81);
    // path.cubicTo(size.width * 0.74, size.height * 0.81, size.width * 0.74,
    //     size.height * 0.81, size.width * 0.74, size.height * 0.81);
    // path.cubicTo(size.width * 0.74, size.height * 0.8, size.width * 0.74,
    //     size.height * 0.8, size.width * 0.74, size.height * 0.8);
    // path.cubicTo(size.width * 0.74, size.height * 0.8, size.width * 0.74,
    //     size.height * 0.8, size.width * 0.74, size.height * 0.8);
    // canvas.drawPath(path, paint);

    // Path number 4

    // paint.color = Color(0xff161616);
    // path = Path();
    // path.lineTo(size.width * 0.74, size.height * 0.8);
    // path.cubicTo(size.width * 0.74, size.height * 0.8, size.width * 0.73,
    //     size.height * 0.79, size.width * 0.72, size.height * 0.79);
    // path.cubicTo(size.width * 0.72, size.height * 0.79, size.width * 0.72,
    //     size.height * 0.79, size.width * 0.72, size.height * 0.78);
    // path.cubicTo(size.width * 0.72, size.height * 0.78, size.width * 0.7,
    //     size.height * 0.78, size.width * 0.7, size.height * 0.78);
    // path.cubicTo(size.width * 0.7, size.height * 0.78, size.width * 0.7,
    //     size.height * 0.79, size.width * 0.7, size.height * 0.79);
    // path.cubicTo(size.width * 0.7, size.height * 0.79, size.width * 0.7,
    //     size.height * 0.8, size.width * 0.71, size.height * 0.8);
    // path.cubicTo(size.width * 0.71, size.height * 0.8, size.width * 0.74,
    //     size.height * 0.81, size.width * 0.74, size.height * 0.81);
    // path.cubicTo(size.width * 0.74, size.height * 0.81, size.width * 0.75,
    //     size.height * 0.81, size.width * 0.75, size.height * 0.81);
    // path.cubicTo(size.width * 0.75, size.height * 0.8, size.width * 0.75,
    //     size.height * 0.8, size.width * 0.74, size.height * 0.8);
    // path.cubicTo(size.width * 0.74, size.height * 0.8, size.width * 0.74,
    //     size.height * 0.8, size.width * 0.74, size.height * 0.8);
    // canvas.drawPath(path, paint);

    // Path number 5

    paint.color = Colors.greenAccent;
    path = Path();
    path.lineTo(size.width * 0.68, size.height * 0.46);
    path.cubicTo(size.width * 0.68, size.height * 0.46, size.width * 0.54,
        size.height * 0.39, size.width * 0.54, size.height * 0.39);
    path.cubicTo(size.width * 0.47, size.height * 0.36, size.width * 0.41,
        size.height * 0.24, size.width * 0.41, size.height * 0.24);
    path.cubicTo(size.width * 0.41, size.height * 0.24, size.width / 3,
        size.height * 0.53, size.width / 3, size.height * 0.53);
    path.cubicTo(size.width / 2, size.height * 0.42, size.width * 0.69,
        size.height / 2, size.width * 0.69, size.height / 2);
    path.cubicTo(size.width * 0.69, size.height / 2, size.width * 0.69,
        size.height * 0.51, size.width * 0.69, size.height * 0.54);
    path.cubicTo(size.width * 0.69, size.height * 0.57, size.width * 0.66,
        size.height * 0.57, size.width * 0.66, size.height * 0.57);
    path.cubicTo(size.width * 0.66, size.height * 0.57, size.width * 0.6,
        size.height * 0.59, size.width * 0.6, size.height * 0.59);
    path.cubicTo(size.width * 0.6, size.height * 0.59, size.width * 0.61,
        size.height * 0.6, size.width * 0.61, size.height * 0.6);
    path.cubicTo(size.width * 0.61, size.height * 0.6, size.width * 0.67,
        size.height * 0.59, size.width * 0.67, size.height * 0.59);
    path.cubicTo(size.width * 0.68, size.height * 0.59, size.width * 0.69,
        size.height * 0.58, size.width * 0.69, size.height * 0.58);
    path.cubicTo(size.width * 0.71, size.height * 0.56, size.width * 0.71,
        size.height * 0.51, size.width * 0.71, size.height * 0.51);
    path.cubicTo(size.width * 0.71, size.height * 0.47, size.width * 0.68,
        size.height * 0.46, size.width * 0.68, size.height * 0.46);
    path.cubicTo(size.width * 0.68, size.height * 0.46, size.width * 0.68,
        size.height * 0.46, size.width * 0.68, size.height * 0.46);
    canvas.drawPath(path, paint);

    // Path number 6

    paint.color = Colors.greenAccent;
    path = Path();
    path.lineTo(size.width * 0.29, size.height * 0.16);
    path.cubicTo(size.width * 0.29, size.height * 0.16, size.width * 0.26,
        size.height * 0.16, size.width * 0.23, size.height * 0.26);
    path.cubicTo(size.width * 0.23, size.height * 0.26, size.width * 0.19,
        size.height * 0.31, size.width * 0.19, size.height * 0.39);
    path.cubicTo(size.width * 0.19, size.height * 0.39, size.width * 0.17,
        size.height * 0.48, size.width * 0.19, size.height * 0.51);
    path.cubicTo(size.width * 0.19, size.height * 0.51, size.width * 0.17,
        size.height * 0.59, size.width / 5, size.height * 0.6);
    path.cubicTo(size.width / 5, size.height * 0.6, size.width * 0.22,
        size.height * 0.66, size.width * 0.27, size.height * 0.6);
    path.cubicTo(size.width * 0.27, size.height * 0.6, size.width * 0.32,
        size.height * 0.6, size.width * 0.34, size.height * 0.49);
    path.cubicTo(size.width * 0.34, size.height * 0.49, size.width * 0.4,
        size.height * 0.41, size.width * 0.4, size.height * 0.31);
    path.cubicTo(size.width * 0.4, size.height * 0.31, size.width * 0.43,
        size.height / 5, size.width * 0.4, size.height * 0.16);
    path.cubicTo(size.width * 0.4, size.height * 0.16, size.width * 0.4,
        size.height * 0.07, size.width * 0.35, size.height * 0.1);
    path.cubicTo(size.width * 0.35, size.height * 0.1, size.width * 0.32,
        size.height * 0.08, size.width * 0.29, size.height * 0.16);
    path.cubicTo(size.width * 0.29, size.height * 0.16, size.width * 0.29,
        size.height * 0.16, size.width * 0.29, size.height * 0.16);
    canvas.drawPath(path, paint);

    // Path number 7

    paint.color = Colors.green;

    path = Path();
    path.lineTo(size.width * 0.29, size.height / 5);
    path.cubicTo(size.width * 0.29, size.height / 5, size.width * 0.26,
        size.height / 5, size.width * 0.24, size.height * 0.28);
    path.cubicTo(size.width * 0.24, size.height * 0.28, size.width * 0.22,
        size.height * 0.32, size.width * 0.22, size.height * 0.38);
    path.cubicTo(size.width * 0.22, size.height * 0.38, size.width * 0.19,
        size.height * 0.45, size.width / 5, size.height * 0.48);
    path.cubicTo(size.width / 5, size.height * 0.48, size.width * 0.19,
        size.height * 0.55, size.width * 0.22, size.height * 0.55);
    path.cubicTo(size.width * 0.22, size.height * 0.55, size.width * 0.24,
        size.height * 0.6, size.width * 0.27, size.height * 0.55);
    path.cubicTo(size.width * 0.27, size.height * 0.55, size.width * 0.31,
        size.height * 0.55, size.width / 3, size.height * 0.46);
    path.cubicTo(size.width / 3, size.height * 0.46, size.width * 0.38,
        size.height * 0.4, size.width * 0.38, size.height * 0.32);
    path.cubicTo(size.width * 0.38, size.height * 0.32, size.width * 0.4,
        size.height * 0.23, size.width * 0.38, size.height / 5);
    path.cubicTo(size.width * 0.38, size.height / 5, size.width * 0.38,
        size.height * 0.13, size.width * 0.34, size.height * 0.16);
    path.cubicTo(size.width * 0.34, size.height * 0.16, size.width * 0.31,
        size.height * 0.13, size.width * 0.29, size.height / 5);
    path.cubicTo(size.width * 0.29, size.height / 5, size.width * 0.29,
        size.height / 5, size.width * 0.29, size.height / 5);
    canvas.drawPath(path, paint);

    // Path number 8

    // paint.color = Color(0xff8e795e);
    // path = Path();
    // path.lineTo(size.width * 0.58, size.height * 0.58);
    // path.cubicTo(size.width * 0.58, size.height * 0.58, size.width * 0.01,
    //     size.height * 0.58, size.width * 0.01, size.height * 0.58);
    // path.cubicTo(size.width * 0.01, size.height * 0.58, size.width * 0.01,
    //     size.height * 0.05, size.width * 0.01, size.height * 0.05);
    // path.cubicTo(size.width * 0.01, size.height * 0.05, size.width * 0.58,
    //     size.height * 0.05, size.width * 0.58, size.height * 0.05);
    // path.cubicTo(size.width * 0.58, size.height * 0.05, size.width * 0.58,
    //     size.height * 0.58, size.width * 0.58, size.height * 0.58);
    // canvas.drawPath(path, paint);

    // Path number 9

    paint.color = Color(0xff292929);
    path = Path();
    path.lineTo(size.width * 0.71, size.height * 0.54);
    path.cubicTo(size.width * 0.71, size.height * 0.54, size.width * 0.69,
        size.height * 0.54, size.width * 0.69, size.height * 0.54);
    path.cubicTo(size.width * 0.69, size.height * 0.54, size.width * 0.68,
        size.height * 0.54, size.width * 0.68, size.height * 0.53);
    path.cubicTo(size.width * 0.68, size.height * 0.52, size.width * 0.69,
        size.height * 0.52, size.width * 0.69, size.height * 0.52);
    path.cubicTo(size.width * 0.69, size.height * 0.52, size.width * 0.71,
        size.height * 0.52, size.width * 0.71, size.height * 0.52);
    path.cubicTo(size.width * 0.71, size.height * 0.52, size.width * 0.71,
        size.height * 0.54, size.width * 0.71, size.height * 0.54);
    path.cubicTo(size.width * 0.71, size.height * 0.54, size.width * 0.71,
        size.height * 0.54, size.width * 0.71, size.height * 0.54);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
