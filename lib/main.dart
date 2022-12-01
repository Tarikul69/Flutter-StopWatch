import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  //Business Logic
  int second = 0, minute=0, hour=0;
  String digitSeconds = "00", digitMinute = "00", digithour = "00";
  Timer? timer;
  bool started = false;
  List laps = [];

  //Stop timer function
  void stop(){
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  //Reset function
  void reset(){
    timer!.cancel();
    setState(() {
      second = 0;
      minute = 0;
      hour = 0;

      digitSeconds ="00";
      digitMinute ="00";
      digithour ="00";

      started = false;
     });
  }

  void addLaps(){
    String lap = "$digithour:$digitMinute:$digitSeconds";
    setState(() {
      laps.add(lap);
    });
  }

  //Start timer
  void start(){
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localSeconts = second+1;
      int localMinutes = minute;
      int localHour = hour;

      if(localSeconts > 59){
        if(localMinutes >59){
          localHour++;
          localMinutes=0;
        }else{
          localHour++;
          localMinutes=0;
        }
      }
      setState(() {
        second = localSeconts;
        minute = localMinutes;
        hour = localHour;

        digitSeconds = (second >= 10) ?"$second":"0$second";
        digithour = ( hour >= 10) ?"$hour":"0$hour";
         digitMinute = (minute >= 10) ?"$minute":"0$minute";


      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C2757),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "StopWtch",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,

                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(child: Text("$digithour:$digitMinute:$digitSeconds",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 82.0,
                  fontWeight: FontWeight.w600,

                ),),),
              Container(
                height: 400.0,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: ListView.builder(
                  itemCount: laps.length,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Lap n${index+1}", style: TextStyle(color: Colors.white, fontSize: 16.0,),),
                          Text("${laps[index]}", style: TextStyle(color: Colors.white, fontSize: 16.0,),)

                        ],
                      ),
                    );
                  },
                ),
              ),

              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: RawMaterialButton(
                    onPressed: (){
                      (!started) ? start():stop();
                    },
                shape: StadiumBorder(side: const BorderSide(color: Colors.blue)
                ),
                  child: Text((!started)? "Start":"Pause", style: TextStyle(color: Colors.white,),),
                ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  IconButton(
                    color: Colors.white,
                    onPressed: (){
                      addLaps();
                    },
                    icon: Icon(Icons.flag),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(child: RawMaterialButton(
                    onPressed: (){
                      reset();
                    },
                    fillColor: Colors.blue,
                    shape: StadiumBorder(side: const BorderSide(color: Colors.blue)
                    ),
                    child: Text((!started)? "Reset" : "Reset", style: TextStyle(color: Colors.white,),),
                  ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

