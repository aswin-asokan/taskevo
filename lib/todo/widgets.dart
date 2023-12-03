import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tasksevo/todo/edittodo.dart';

Widget toDO(
    BuildContext context,
    bool val,
    String head,
    String desc,
    String priority,
    DateTime date,
    Function(bool?)? onChanged,
    Function() deleteToDo,
    Function(String h, String d, String p, DateTime dT) updateToDo) {
  var json = jsonDecode(desc);
  Document _doc = Document.fromJson(json);
  QuillController _controller = QuillController(
      document: _doc, selection: TextSelection.collapsed(offset: 0));
  String dateString = date.day.toString() +
      "-" +
      date.month.toString() +
      "-" +
      date.year.toString();
  Color color = Colors.grey;
  if (priority == "high")
    color = Colors.redAccent;
  else if (priority == "mid")
    color = Colors.deepOrangeAccent;
  else if (priority == "low")
    color = Colors.lightGreenAccent;
  else if (priority == "no") color = Colors.grey;
  return Container(
    child: Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
      child: Column(
        children: [
          Container(
            constraints: BoxConstraints(minHeight: 70),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                          shape: CircleBorder(),
                          value: val,
                          onChanged: onChanged),
                      Text(
                        head,
                        style: GoogleFonts.openSans(
                            decoration: val ? TextDecoration.lineThrough : null,
                            fontSize: 20),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => edittodo(
                                  head: head,
                                  desc: desc,
                                  priority: priority,
                                  date: date)),
                        );
                        if (result['action'] == 'delete') {
                          deleteToDo();
                        } else {
                          updateToDo(result['heading'], result['description'],
                              result['priority'], result['date']);
                        }
                      },
                      icon: Icon(Icons.edit))
                ]),
          ),
          if (!_doc.isEmpty())
            Container(
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: Padding(
                padding: EdgeInsets.only(left: 20, bottom: 10),
                child: QuillProvider(
                  configurations: QuillConfigurations(
                    controller: _controller,
                    sharedConfigurations: const QuillSharedConfigurations(
                      locale: Locale('en'),
                    ),
                  ),
                  child: QuillEditor.basic(
                    configurations: const QuillEditorConfigurations(
                        scrollPhysics: NeverScrollableScrollPhysics(),
                        maxHeight: 60,
                        readOnly: true,
                        showCursor: false),
                  ),
                ),
              ),
            ),
          if (dateString != "1-1-0")
            Container(
                color: Theme.of(context).colorScheme.secondaryContainer,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(left: 15, bottom: 5),
                  child: Text(
                    "Due on: ${dateString}",
                  ),
                )),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              color: color,
            ),
            height: 5,
          )
        ],
      ),
    ),
  );
}
