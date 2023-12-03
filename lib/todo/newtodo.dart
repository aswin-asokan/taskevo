import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:flutter_quill/flutter_quill.dart';

class newtodo extends StatefulWidget {
  const newtodo({super.key});

  @override
  State<newtodo> createState() => _newtodState();
}

class _newtodState extends State<newtodo> {
  QuillController _controller = QuillController.basic();
  TextEditingController controller1 = TextEditingController();
  String head = "", _text = "";
  Color color = Colors.grey;
  int counter = 0;
  String prio = "no";
  DateTime dateVal = DateTime(0);
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
                  var json = _controller.document.toDelta().toJson();
                  String s = jsonEncode(json);
                  _text = s;
                });
                if (head.isNotEmpty) {
                  Navigator.pop(
                    context,
                    {
                      'heading': head,
                      'description': _text,
                      'priority': prio,
                      'date': dateVal
                    },
                  );
                }
              },
              icon: Icon(Icons.check))
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
            Padding(
              padding: EdgeInsets.only(left: 10, top: 10, right: 10),
              child: TextField(
                  textCapitalization: TextCapitalization.words,
                  autofocus: true,
                  controller: controller1,
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      hintText: 'Task Name',
                      suffixIcon: IconButton(
                        onPressed: () {
                          DatePickerBdaya.showDatePicker(context,
                              theme: DatePickerThemeBdaya(
                                  doneStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  cancelStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  itemStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.surface),
                              showTitleActions: true,
                              minTime: DateTime.now(),
                              maxTime: DateTime(DateTime.now().year + 50),
                              onChanged: (date) {}, onConfirm: (date) {
                            dateVal = date;
                            setState(() {});
                          },
                              currentTime: DateTime.now(),
                              locale: LocaleType.en);
                        },
                        icon: Icon(Icons.calendar_today_outlined),
                      ),
                      prefixIcon: IconButton(
                          onPressed: () {
                            counter++;
                            if (counter == 1) {
                              color = Colors.redAccent;
                              prio = "high";
                            } else if (counter == 2) {
                              color = Colors.deepOrangeAccent;
                              prio = "mid";
                            } else if (counter == 3) {
                              color = Colors.lightGreenAccent;
                              prio = "low";
                            } else {
                              counter = 0;
                              color = Colors.grey;
                              prio = "no";
                            }
                            setState(() {});
                          },
                          icon: Icon(
                            Icons.circle_sharp,
                            color: color,
                          )))),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: TextField(
                  enabled: false,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    hintText: 'Description',
                  )),
            ),
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.only(right: 20, left: 20, bottom: 50, top: 10),
                child: QuillEditor.basic(
                  configurations: QuillEditorConfigurations(
                      readOnly: false, autoFocus: true),
                ),
              ),
            ),
            QuillToolbar(
              configurations: QuillToolbarConfigurations(
                  toolbarSectionSpacing: 0,
                  sectionDividerSpace: 0,
                  showSubscript: false,
                  showSuperscript: false,
                  showInlineCode: false,
                  showFontFamily: false,
                  showFontSize: false,
                  showColorButton: false,
                  showBackgroundColorButton: false,
                  showCodeBlock: false,
                  showQuote: false,
                  showIndent: false,
                  showSearchButton: false,
                  showHeaderStyle: false,
                  showClearFormat: false,
                  multiRowsDisplay: false,
                  toolbarIconAlignment: WrapAlignment.center),
            ),
          ],
        ),
      ),
    );
  }
}
