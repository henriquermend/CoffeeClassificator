import 'package:flutter/material.dart';
import 'dar:async';
import 'dart:math';

class SplashScreen extends StatefulWidget{
  @override_SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerPRoviderStateMixin {
  AnimationController _controller;
  List<Bean> _beans = [];
  final int _numberOfBeans = 30;
  final Random _random = Random();

  @override void initState(){
    super.initState();
    _controller =
    AnimationController(vsync: this, duration: Duration(seconds: 3));
    _controller.forward();
    _controller.addListener((){
      _updateBeans();
    });
    _initBeans();
  } 
}

  void _initBeans() {
    _beans =
List.generate(_numberOfBeans, (index)
=> Bean(
      id : index,
      x : _random.nextDouble(),
      startY : _random.nextDouble() * -0.2,
      endY : 1.0 + _random.nextDouble(),
      size : 0.2 + _random.nextDouble() * 0.3,
   ));    
}

@override
void dispose(){
  _controller.dispose();
  super.dispose();
}

@override 
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: _beans.map((bean)) =>
Positioned(
      top: bean.y *
MediaQuery.of(context).size.height,
          left: bean.x *      
MediaQuery.of(context).size.width,
          child: Container(
            height:
MediaQuery.of(context).size.height *
bean.size,
              width:
MediaQuery.of(context).size.width *
bean.size,
          child: Image.asset('assets/images/coffe_bean.png'),
),      
    )).toList(),
),
);
}
}

  class Bean {
    final int id;
    final double x;

    double y;
    final double startY;
    final double endY
    final double size;

    Bean({this.id, this.x, this.y, this.startY, this.endY, this.size});
  }

  