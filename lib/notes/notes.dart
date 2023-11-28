import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:todo/notes/notesWrite.dart';

import '../database.dart';
import '../widgets.dart';

class notes extends StatefulWidget {
  const notes({super.key, Function? addW()?});

  @override
  State<notes> createState() => _notesState();
}

TextEditingController controller1 = TextEditingController();

class _notesState extends State<notes> {
  @override
  final _myBox = Hive.box('mybox');
  database db = database();

  @override
  void initState() {
    if (_myBox.get("NOTES") == null) {
      db.createInitialDataNotes();
    } else {
      // there already exists data
      db.loadDataNotes();
    }

    // TODO: implement initState
    super.initState();
  }

  bool value = false;

  @override
  addWidget(String head, String desc) {
    setState(() {
      db.notes.insert(
        0,
        [false, head, desc],
      );
    });
    db.updateDataBaseNotes();
  }

  update(index, String head, String desc) {
    setState(() {
      db.notes.removeAt(index);
      db.notes.insert(
        index,
        [false, head, desc],
      );
    });
    db.updateDataBaseNotes();
  }

  void deleteWidget(int index) {
    setState(() {
      db.notes.removeAt(index);
    });
    db.updateDataBaseNotes();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Notes',
          style:
              GoogleFonts.openSans(fontSize: 30, fontWeight: FontWeight.w400),
        ),
      ),
      body: ListView.builder(
          itemCount: db.notes.length,
          itemBuilder: (context, index) {
            return Notes(
              context,
              db.notes[index][1],
              db.notes[index][2],
              () => deleteWidget(index),
              (h, n) => update(index, h, n),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => write()),
          );
          // Call the function with the result from Page2
          addWidget(result['heading'], result['description']);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
