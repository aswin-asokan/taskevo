import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'dart:convert';

class write extends StatefulWidget {
  write({
    super.key,
  });

  @override
  State<write> createState() => _writeState();
}

class _writeState extends State<write> {
  QuillController _controller = QuillController.basic();
  TextEditingController controller1 = TextEditingController();
  String head = "", _text = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: TextField(
            textCapitalization: TextCapitalization.words,
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
                  head = controller1.text.toString();
                  var json = _controller.document.toDelta().toJson();
                  String s = jsonEncode(json);
                  _text = s;
                });

                Navigator.pop(
                  context,
                  {
                    'heading': head,
                    'description': _text,
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
                  configurations: const QuillEditorConfigurations(
                      readOnly: false, autoFocus: true),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
