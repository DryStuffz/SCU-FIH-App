import 'package:flutter/material.dart';


class ArcProgressPainter extends CustomPainter {
  final double arclength;
  final Color arcColor;
  final double pi = 3.1415926535897932;


  ArcProgressPainter({
    required this.arclength,
    required this.arcColor,

  });
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = arcColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ;
    
    //draw arc
    canvas.drawArc(
        const Offset(100, 100) & const Size(100, 100),
        0.75*2*pi, //radians
        arclength * 2*pi, //radians
        true,
        paint1,
        
        );
  }

  @override
  bool shouldRepaint(ArcProgressPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(ArcProgressPainter oldDelegate) => false;
}
