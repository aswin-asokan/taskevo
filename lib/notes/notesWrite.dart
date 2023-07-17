import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:todo/notes/notes.dart';

import '../database.dart';

class write extends StatefulWidget {
  write({
    super.key,
  });

  @override
  State<write> createState() => _writeState();
}

class _writeState extends State<write> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  late String head, desc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  head = controller1.text.toString();
                  desc = controller2.text.toString();
                });

                Navigator.pop(
                  context,
                  {
                    'heading': head,
                    'description': desc,
                  },
                );
              },
              icon: Icon(Icons.check))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                TextField(
                  controller: controller1,
                  style: GoogleFonts.openSans(fontSize: 30),
                  decoration: InputDecoration.collapsed(
                      hintText: 'Title',
                      hintStyle: GoogleFonts.openSans(fontSize: 30)),
                ),
                Divider(color: Colors.grey),
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: controller2,
                  autofocus: true,
                  maxLines: null,
                  style: GoogleFonts.openSans(fontSize: 15),
                  decoration: InputDecoration.collapsed(
                      hintText: 'Write your notes here',
                      hintStyle: GoogleFonts.openSans(fontSize: 15)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
