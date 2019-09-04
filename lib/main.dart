import "package:flutter/material.dart";
import "painter.dart";

void main() => runApp(MyApp());

class Drawer extends StatefulWidget{
  State<Drawer> createState() => DrawerState();
}

class DrawerState extends State<Drawer> {
  final fractal = DrawFractal();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Fractals App"),
          ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.black,
                width: Size.infinite.width,
                height: Size.infinite.height,
                child: CustomPaint(painter: fractal),
              ),
            ),
        ]),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FloatingActionButton(
              child: Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  fractal.decreaseLevel();
                });
              },
            ),
            FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  fractal.increaseLevel();
                });
              },
            ),
        ]),
      );
  }
}

class MyApp extends StatelessWidget {
  final drawer = new Drawer();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Drawer()
    );
  }
}

