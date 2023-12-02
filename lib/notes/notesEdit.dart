import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class edit extends StatefulWidget {
  final String head, desc;
  edit({super.key, required this.head, required this.desc});

  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {
  String text = "";
  @override
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
    var json = jsonDecode(d);
    Document _doc = Document.fromJson(json);
    TextEditingController controller1 = TextEditingController(text: h);
    TextEditingController _textEditingController =
        TextEditingController(text: d);
    QuillController _controller = QuillController(
        document: _doc, selection: TextSelection.collapsed(offset: 0));
    late String headE;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextField(
            controller: controller1,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            decoration: InputDecoration.collapsed(hintText: 'Title')),
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
                  var json = _controller.document.toDelta().toJson();
                  String s = jsonEncode(json);
                  text = s;
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
              icon: Icon(Icons.save_outlined))
        ],
      ),
      body: QuillProvider(
        configurations: QuillConfigurations(
          controller: _controller,
          sharedConfigurations: const QuillSharedConfigurations(
            locale: Locale('en'),
          ),
        ),
        child: Column(
          children: [
            const QuillToolbar(
              configurations: QuillToolbarConfigurations(
                  toolbarSectionSpacing: 0,
                  sectionDividerSpace: 0,
                  showSubscript: false,
                  showSuperscript: false,
                  showInlineCode: false,
                  toolbarIconAlignment: WrapAlignment.center),
            ),
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.only(right: 20, left: 20, bottom: 50, top: 10),
                child: QuillEditor.basic(
                  configurations: QuillEditorConfigurations(
                    readOnly: false,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
