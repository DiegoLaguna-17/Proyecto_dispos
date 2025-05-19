import 'package:flutter/material.dart';

class PeatonCustomPainter extends CustomPainter {
  Color color;
  double x, y;

  PeatonCustomPainter(this.color,this.x,this.y);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    Path m=new Path();

    canvas.translate(-x, -y);
    double w = size.width;
    double h = size.height;
    m.moveTo(x+2.2*w/4, y+2*h/8);

    m.lineTo(x+2.2*w/4, y+2.5*h/8);

    m.lineTo(x+3*w/4,y+3.1*h/8);
    m.lineTo(x+2.8*w/4,y+3.1*h/8);
    m.lineTo(x+2.2*w/4,y+2.7*h/8);

    m.lineTo(x+2.2*w/4,y+6*h/8);

    m.lineTo(x+3*w/4,y+h);
    m.lineTo(x+2.8*w/4, y+h);
    m.lineTo(x+2.1*w/4,y+6.2*h/8);

    m.lineTo(x+1.1*w/4,y+h);
    m.lineTo(x+0.9*w/4,y+h);
    m.lineTo(x+2*w/4,y+6*h/8);

    m.lineTo(x+2*w/4, y+2.7*h/8);

    m.lineTo(x+1.4*w/4,y+3.1*h/8);

    m.lineTo(x+1.2*w/4,y+3.1*h/8);
    m.lineTo(x+2*w/4,y+2.5*h/8);

    m.lineTo(x+2*w/4, y+2.5*h/8);
    m.lineTo(x+2*w/4, y+2*h/8);

    
    
    
  paint.color=color;
    canvas.drawPath(m, paint);
    canvas.drawCircle(Offset(x + 2.1*w/4, y + 1.5 * h / 8), w/10, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class PeatonIcono extends StatelessWidget {
  final double size;
  final Color color;
  double x, y;  
  PeatonIcono({this.size = 48.0,required this.color,required this.x,required this.y});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: PeatonCustomPainter(color,x,y),
    );
  }
}


class AutoCustomPainter extends CustomPainter {
  final Color color;

  AutoCustomPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    double w = size.width;
    double h = size.height;

    // Cuerpo del auto
    final Rect body = Rect.fromLTWH(w * 0.1, h * 0.4, w * 0.8, h * 0.3);
    final RRect roundedBody = RRect.fromRectAndRadius(body, Radius.circular(10));
    canvas.drawRRect(roundedBody, paint);

    // Cabina
    final Path cabina = Path();
    cabina.moveTo(w * 0.3, h * 0.4);
    cabina.lineTo(w * 0.4, h * 0.2);
    cabina.lineTo(w * 0.6, h * 0.2);
    cabina.lineTo(w * 0.7, h * 0.4);
    cabina.close();

    canvas.drawPath(cabina, paint);

    // Ruedas
    final Paint wheelPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(w * 0.25, h * 0.75), h * 0.1, wheelPaint);
    canvas.drawCircle(Offset(w * 0.75, h * 0.75), h * 0.1, wheelPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class AutoIcono extends StatelessWidget {
  final double size;
  final Color color;

  const AutoIcono({super.key, this.size = 100.0, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: AutoCustomPainter(color),
    );
  }
}
