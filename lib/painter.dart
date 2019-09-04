
import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import "koch.dart";

enum Fractals {
  KOCH,
}

Offset convert(Vector2D<double> vec) {
  return Offset(vec.x, vec.y);
}

class DrawFractal extends CustomPainter {
    final paintConfig = Paint();
    int _level = 0;
    bool _repaint = false;
    Fractals _currentFractal = Fractals.KOCH;

    DrawFractal() {
      paintConfig.color = Colors.lightGreen;
      paintConfig.strokeWidth = 1;
    }

    void increaseLevel() {
      if (_level >= 7) return;

      _level++;
      _repaint = true;
    }

    void decreaseLevel() {
      if (_level == 0) return;

      _level--;
      _repaint = true;
    }

    void selectFractal(Fractals fract) {
      _currentFractal = fract;
    }

    Path fractalPath(Size size) {
      if (_currentFractal == Fractals.KOCH) {
        var points = buildKoch(lvl: _level, width: size.height);
        var offsetPoints = points.map(convert).toList();
        return Path()..addPolygon(offsetPoints, false);
      }
    }

    @override
    void paint(Canvas canvas, Size size) {
      canvas.translate(size.width/2, 0);
      canvas.rotate(3.141592/2);

      var path = fractalPath(size);
      canvas.drawPath(path, paintConfig);
    }

    @override
    bool shouldRepaint(CustomPainter oldDelegate) {
      return _repaint;
    }
}

