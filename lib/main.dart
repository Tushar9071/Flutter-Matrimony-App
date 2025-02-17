import 'package:flutter/material.dart';
import 'package:submition/Pages/main_page.dart';

import 'Pages/Pages_app/user_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:MainPage(),
    );
  }
}

