import 'package:flutter/material.dart';
import 'package:tasksevo/todo/home.dart';
import 'package:tasksevo/notes/notes.dart';

class navigation extends StatefulWidget {
  const navigation({super.key});

  @override
  State<navigation> createState() => _navigationState();
}

class _navigationState extends State<navigation> {
  int i = 1;
  final pages = [notes(), home()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[i],
      bottomNavigationBar: NavigationBar(
          selectedIndex: i,
          onDestinationSelected: (index) => setState(() => i = index),
          destinations: [
            NavigationDestination(
                icon: Icon(Icons.feed_outlined), label: 'Notes'),
            NavigationDestination(
                icon: Icon(Icons.checklist_outlined), label: 'To-Do')
          ]),
    );
  }
}
