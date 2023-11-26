import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/home.dart';
import 'package:markdown_toolbar/markdown_toolbar.dart';
import 'package:url_launcher/url_launcher.dart';

class edit extends StatefulWidget {
  final String head, desc;
  edit({super.key, required this.head, required this.desc});

  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {
  String text = "";
  @override
  int _tappedCount = 0; // Declare the TextEditingController
  void initState() {
    String h = widget.head;
    String d = widget.desc;
    text = widget.desc; // Update the text when typing
    // TODO: implement initState
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    String h = widget.head;
    String d = widget.desc;
    TextEditingController controller1 = TextEditingController(text: h);
    TextEditingController _textEditingController =
        TextEditingController(text: d);
    late String headE;
    var showEditor = !(_tappedCount % 2 == 0);
    if (showEditor) {
      _textEditingController.text = text;
    }
    bool checkbox = false;
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
                  _textEditingController.text = text;
                  setState(() => {this._tappedCount++});
                });
              },
              icon: Icon(Icons.notes_outlined)),
          IconButton(
              onPressed: () {
                setState(() {
                  headE = controller1.text.toString();
                  text = _textEditingController.text.toString();
                });
                Navigator.pop(
                  context,
                  {
                    'action': 'delete',
                    'heading': headE,
                    'description': text,
                  },
                );
              },
              icon: Icon(Icons.delete_outline_outlined)),
          IconButton(
              onPressed: () {
                setState(() {
                  headE = controller1.text.toString();
                  _textEditingController.text = text;
                  text = _textEditingController.text.toString();
                });
                Navigator.pop(
                  context,
                  {
                    'action': 'edit',
                    'heading': headE,
                    'description': text,
                  },
                );
              },
              icon: Icon(Icons.check))
        ],
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          _textEditingController.text =
                              '${_textEditingController.text}\n[link name]("https://www.example.com")';
                          _textEditingController.selection =
                              TextSelection.fromPosition(
                            TextPosition(
                                offset: _textEditingController.text.length),
                          );
                        },
                        icon: Icon(Icons.link))
                  ],
                ),
                height: 50,
              ),
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
              showEditor
                  ? Expanded(
                      child: TextField(
                        controller: _textEditingController,
                        maxLines: null,
                        style: GoogleFonts.openSans(fontSize: 15),
                        decoration: InputDecoration.collapsed(
                            hintText: 'Write your notes here',
                            hintStyle: GoogleFonts.openSans(fontSize: 15)),
                        onChanged: (value) {
                          text = value;
                        },
                      ),
                    )
                  : Expanded(
                      child: SizedBox.expand(
                        child: SingleChildScrollView(
                            child: Padding(
                          padding: EdgeInsets.only(bottom: 50),
                          child: MarkdownBody(
                            checkboxBuilder: (bool isChecked) {
                              return GestureDetector(
                                onTap: () {
                                  if (isChecked == checkbox) {
                                    checkbox = !isChecked;
                                  }
                                },
                                child: Container(
                                  width: 20.0,
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:
                                        Border.all(color: Colors.blueAccent),
                                    color: isChecked ? Colors.blueAccent : null,
                                  ),
                                  child: isChecked
                                      ? Icon(Icons.check,
                                          size: 16.0, color: Colors.white)
                                      : null,
                                ),
                              );
                            },
                            data: this.text,
                          ),
                        )),
                      ),
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          _textEditingController.text = '${_textEditingController.text}\n- ';
          _textEditingController.selection = TextSelection.fromPosition(
            TextPosition(offset: _textEditingController.text.length),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
