import 'package:flutter/material.dart';
import 'package:untitled1/Screens/1home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontFamily: 'SfPRO'),
          bodyMedium: TextStyle(fontFamily: 'SfPRO'),
          bodySmall: TextStyle(fontFamily: 'SfPRO'),
          labelMedium: TextStyle(fontFamily: 'SfPRO'),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: HotelPage(),
    );
  }
}
