import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class write extends StatefulWidget {
  write({
    super.key,
  });

  @override
  State<write> createState() => _writeState();
}

class _writeState extends State<write> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController _textEditingController =
      TextEditingController(text: '');
  String head = "", _text = "";
  int _tappedCount = 1;
  @override
  Widget build(BuildContext context) {
    var showEditor = !(_tappedCount % 2 == 0);
    if (!showEditor) {
      _textEditingController.text = _text;
    }
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
                  setState(() => {this._tappedCount++});
                });
              },
              icon: Icon(Icons.notes_outlined)),
          IconButton(
              onPressed: () {
                setState(() {
                  head = controller1.text.toString();
                  _text = _textEditingController.text.toString();
                });

                Navigator.pop(
                  context,
                  {
                    'heading': head,
                    'description': _text,
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
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: TextField(
                          controller: _textEditingController,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            setState(() {
                              _text = value;
                            });
                          },
                        ),
                      ),
                    )
                  : Expanded(
                      child: SizedBox.expand(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: MarkdownBody(data: this._text),
                        ),
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
