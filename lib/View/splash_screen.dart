import 'dart:async';

import 'package:covid_19_app/View/world_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math'as math;

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> with TickerProviderStateMixin{
  late final AnimationController _controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync:this
  )..repeat();
  @override
  dispose(){
    _controller.dispose();
  }
  void initState(){
    Timer(Duration(seconds: 5), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return WorldStates();
      }));

    });

  }
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
              animation: _controller,
              builder: (context,Widget? child){
                return Transform.rotate(
                  child:Container(
                    height: 200,
                    width: 200,
                    child: Center(
                      child: Image(
                        image: AssetImage('images/virus.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ) ,
                    angle: _controller.value * 2.0 * math.pi);
              }),
          SizedBox(height: MediaQuery.sizeOf(context).height * .08,),
          Align(
            alignment: Alignment.center,
            child: Text('Covid-19\nTracker App',textAlign: TextAlign.center,style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
              color: Colors.white

            ),),
          )
        ],
      ),
    );
  }
}
