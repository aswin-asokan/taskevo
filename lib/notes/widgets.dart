import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasksevo/notes/notesEdit.dart';

Widget Notes(BuildContext context, String head, String desc, Function() delete,
    Function(String hN, String dN) update) {
  var json = jsonDecode(desc);
  Document _doc = Document.fromJson(json);
  QuillController _controller = QuillController(
      document: _doc, selection: TextSelection.collapsed(offset: 0));
  return Padding(
    padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
    child: Container(
      child: Container(
        constraints: BoxConstraints(minHeight: 70),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    head,
                    style: GoogleFonts.openSans(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => edit(
                                    head: head,
                                    desc: desc,
                                  )),
                        );
                        if (result['action'] == 'delete') {
                          delete();
                        } else {
                          update(result['heading'], result['description']);
                        }
                      },
                      icon: Icon(Icons.edit))
                ],
              ),
              QuillProvider(
                configurations: QuillConfigurations(
                  controller: _controller,
                  sharedConfigurations: const QuillSharedConfigurations(
                    locale: Locale('en'),
                  ),
                ),
                child: QuillEditor.basic(
                  configurations: const QuillEditorConfigurations(
                      scrollPhysics: NeverScrollableScrollPhysics(),
                      maxHeight: 100,
                      readOnly: true,
                      showCursor: false),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
