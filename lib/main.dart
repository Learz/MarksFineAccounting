import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marks_fine_accounting/constants/colors.dart';
import 'package:marks_fine_accounting/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: MyTheme.primaryColor));
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Mark's Fine Accounting",
      home: MyHomePage(title: "Mark's Fine Accounting"),
    );
  }
}
