import 'package:employee_information/pages/add_employee_page.dart';
import 'package:employee_information/pages/home_page.dart';
import 'package:employee_information/pages/update_employee_page.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/add-page': (context) => const AddPage(),
        '/update-page': (context) => const UpdatePage(),
      },
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    );
  }
}
