import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/home.dart';
import 'package:todo/navigation.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('mybox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
            scaffoldBackgroundColor:
                Color.fromRGBO(63, 63, 63, 1)), // standard dark theme
        themeMode: ThemeMode.system,
        home: navigation());
  }
}
