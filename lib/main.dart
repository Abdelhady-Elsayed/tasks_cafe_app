import 'package:flutter/material.dart';

import 'WelcomeScreen.dart';


void main(){
  runApp(TasksCafeApp());
}

class TasksCafeApp extends StatelessWidget {
  const TasksCafeApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasks Cafe',
      home: WelcomeScreen(),
    );
  }
}
