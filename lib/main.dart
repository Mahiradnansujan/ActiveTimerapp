import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timerapp/timer_body.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ActiveTimerApp",
      home: ActiveTimer(),
    );
  }
}
class ActiveTimer extends StatelessWidget {
  const ActiveTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 105, 141, 106),
      appBar: AppBar(
        title: Text("Active Timer"),
        backgroundColor: Color.fromARGB(255, 223, 192, 226),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}