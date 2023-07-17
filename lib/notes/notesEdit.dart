import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class edit extends StatefulWidget {
  final String head, desc;
  edit({super.key, required this.head, required this.desc});

  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {
  @override
  void initState() {
    String h = widget.head;
    String d = widget.desc;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String h = widget.head;
    String d = widget.desc;
    TextEditingController controller1 = TextEditingController(text: h);
    TextEditingController controller2 = TextEditingController(text: d);
    late String headE, descE;
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
                  headE = controller1.text.toString();
                  descE = controller2.text.toString();
                });
                Navigator.pop(
                  context,
                  {
                    'action': 'delete',
                    'heading': headE,
                    'description': descE,
                  },
                );
              },
              icon: Icon(Icons.delete_outline_outlined)),
          IconButton(
              onPressed: () {
                setState(() {
                  headE = controller1.text.toString();
                  descE = controller2.text.toString();
                });
                Navigator.pop(
                  context,
                  {
                    'action': 'edit',
                    'heading': headE,
                    'description': descE,
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
                  maxLines: null,
                  autofocus: true,
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
