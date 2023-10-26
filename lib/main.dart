import 'dart:io';

import 'package:flutter/material.dart';

import 'screens/task_list.dart';

class MyHttpOverrides extends HttpOverrides{

  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primaryColor: Colors.blue, // Sesuaikan dengan tema yang Anda inginkan
      ),
      home: TaskListScreen(),
    );
  }
}
