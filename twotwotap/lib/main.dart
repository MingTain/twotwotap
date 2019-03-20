import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:io';
main() => runApp(TwoTwoTap());

class TwoTwoTap extends StatefulWidget {
  @override
  createState() => _TwoTwoTapState();
}
  
class _TwoTwoTapState extends State<TwoTwoTap>{
  int count = 0;
  Widget widgetShowNow;
  Random random = Random();
  List<Color> colors = [ 
    Color.fromARGB(255, 124,252,0),
    Color.fromARGB(255, 178, 235, 242),
    Color.fromARGB(255, 129, 212, 250),
    Color.fromARGB(255, 159, 168, 218),
    Color.fromARGB(255, 255, 245, 157),
    Color.fromARGB(255, 176, 190, 197),
    Color.fromARGB(255, 118, 255, 3),
    Color.fromARGB(255, 126, 87, 194),
    Color.fromARGB(255, 156, 39, 176),
    Color.fromARGB(255, 252, 0, 0)
  ];
  Color color;
  Future<bool> done;
  _TwoTwoTapState() {
    widgetShowNow = _buildStepTap(count);
    color = colors[1];
  }
  @override
  build(BuildContext context) {
    return MaterialApp(
      title: "Two Two Tap",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: widgetShowNow,
      )
    );
  }
  Widget _makeupScreen(Widget child, {Function() func}) {
    return Material(
      elevation: 20.0,
      borderRadius: BorderRadius.circular(100.0),
      shadowColor: color == null ? Color.fromARGB(255, 124,252,0) : color,
      child: InkWell(
        child: child,
        onTap: func == null ? () => {} : func,
        splashColor: color =_randomColor()
      ),
    );
  }
  Widget _buildStepTap(int count) {
    

    if(count < 1)
    {
      return _makeupScreen(
        new Center(
          child: Text("Tap Screen For Start"),
        ), 
        func: () => setState(() {
          widgetShowNow = _buildStepTap(++count);
        })
      );
    }else
    {
      return _makeupScreen(
        new Center(
          child: Text("Tap Now"),
        ), 
        func: () => setState(() {
          print(done);
          print("1: $color");
          print("2: $colors[9]");

          print("Count: $count");
          print("Equal: ${(color == colors[9]) ? "True" : "False"}");
          if (color == colors[9])
          {
            done =waitting();
            widgetShowNow = _buildCheckPoint();
            done = Future.value(null);

          }
          else
              widgetShowNow = _buildStepTap(++count);
          //print(colors.last);
          //done = waitting();

          //widgetShowNow = _buildCheckPoint();
        })
      );
    }
  }
  Widget _buildStopTap() {
    print("Now");

    return _makeupScreen(
      new Center(
        child: Text("Stop Tap"),
      ), 
      func: () {
        setState(() {
          widgetShowNow = _buildGameOver();          
        });
      }
    );
  }

  Future<bool> waitting() {
    Duration oneSecond = new Duration(seconds: 1);
    return Future<bool>.delayed(oneSecond, () => true);;
  }

  Widget _buildCheckPoint() {
  print("Now 1");
  return  FutureBuilder(
      future: done,
      builder: (context, snap){
        if(snap.hasData)
          return _buildStepTap(++count);
        return _buildStopTap();
      },
    );
  }

  Widget _buildGameOver() {
    return _makeupScreen(
      new Center(
        child: Text("You Fail"),
      ), 
      func: () => setState(() {
        widgetShowNow = _buildStepTap(count = 0);
      })
    );
  }

  Color _randomColor() => colors[random.nextInt(10)];

}




