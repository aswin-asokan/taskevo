import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:flutter_quill/flutter_quill.dart';

class edittodo extends StatefulWidget {
  final String head, desc, priority;
  final DateTime date;
  edittodo(
      {super.key,
      required this.head,
      required this.desc,
      required this.priority,
      required this.date});
  @override
  State<edittodo> createState() => _edittodoState();
}

class _edittodoState extends State<edittodo> {
  String text = "";
  Color color = Colors.grey;
  int counter = 0;
  String prio = "no";
  String heading = "";
  DateTime dateVal = DateTime(0);
  Document _doc = Document();
  @override
  void initState() {
    String d = widget.desc;
    text = widget.desc;
    heading = widget.head;
    dateVal = widget.date;
    prio = widget.priority;
    color = (prio == "high")
        ? Colors.redAccent
        : (prio == "mid")
            ? Colors.deepOrangeAccent
            : (prio == "low")
                ? Colors.lightGreenAccent
                : Colors.grey;
    var json = jsonDecode(d);
    _doc = Document.fromJson(json);
    super.initState();
  }

  Widget build(BuildContext context) {
    String d = widget.desc;
    TextEditingController controller1 = TextEditingController(text: heading);
    TextEditingController _textEditingController =
        TextEditingController(text: d);
    QuillController _controller = QuillController(
        document: _doc, selection: TextSelection.collapsed(offset: 0));
    late String headE;
    _controller.document.changes.listen((event) {
      _doc = _controller.document;
    });
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
                  text = _textEditingController.text.toString();
                });
                Navigator.pop(
                  context,
                  {
                    'action': 'delete',
                    'heading': headE,
                    'description': text,
                    'priority': prio,
                    'date': dateVal
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
                    'priority': prio,
                    'date': dateVal
                  },
                );
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
                    autofocus: true,
                    onChanged: (String value) async {
                      heading = value;
                    },
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
                          )),
                    ))),
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
