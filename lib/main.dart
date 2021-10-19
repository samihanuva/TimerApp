import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();
  
int percentage=0;
 int _counter = 10;
 double _count =0.00;
 late Timer _timer;
 late AnimationController controller;

 void startTimer() {
  
   _timer = Timer.periodic(const Duration(seconds: 1), (timer) { 
     if(_counter >0){
       setState(() {
         _counter--;
         percentage++;
         _count = _count+0.01;
       });
     }
     
     else {
     audioCache.load('alarm.mp3');
      audioCache.play('alarm.mp3');
       _timer.cancel();
      
       
     }
      
   });
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.purple[100],
      appBar:AppBar(
        backgroundColor: Colors.purple[900],
        title: const Text('Time Maintenance App'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            SizedBox(width: 250, height: 250, child: CircularProgressIndicator(value:  percentage/10 ,
              strokeWidth: 10,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
              backgroundColor: Colors.white,),)
            ,
             SizedBox(height: 30, width: MediaQuery.of(context).size.width,),
              Text('$_counter',
              style: const TextStyle(
                color: Colors.deepPurpleAccent,
                fontWeight: FontWeight.bold, 
                fontSize: 50,
              ),
              ),
              const SizedBox(height: 50,),

              SizedBox(
                height: 50,width: 150,
                child: ElevatedButton(onPressed: () {
                  startTimer();
                },
                style: ElevatedButton.styleFrom(
                   primary: Colors.pink[100],
                 ),
                 child: const Text('Start',)
                 ),
              ),
               const SizedBox(height: 30,),
            
               SizedBox(
                 height:50,width:150,
                 child: ElevatedButton(onPressed: () {
                   setState(() {
                  _timer.cancel();
                  
                     
                   });
                             },
                             style: ElevatedButton.styleFrom(
                   primary: Colors.deepOrange[100],
                 ),
                 child: const Text('Pause')
                 ),
               ),
               const SizedBox(height: 30,),
            
               SizedBox(
                 height: 50,width: 150,
                 child: ElevatedButton(onPressed: () {
                   
                  
                  setState(() {
                  _timer.cancel();
                    _counter=10;
                    percentage=0;
                    //_count =0.00;
                  });
              },style: ElevatedButton.styleFrom(
                   primary: Colors.green[100],
                 ),
                 child: const Text('Reset')
                 ),
               ),     
        ],
        ),
      ),
      
    );
  }
}