import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:todo/database.dart';
import 'package:todo/todo/newtodo.dart';
import 'package:todo/todo/widgets.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

TextEditingController controller1 = TextEditingController();
int counter = 0;
Color color = Colors.white;

class _homeState extends State<home> {
  final _myBox = Hive.box('mybox');
  database db = database();

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      // there already exists data
      db.loadData();
    }

    // TODO: implement initState
    super.initState();
  }

  bool value = false;

  @override
  void addWidget(String head, String description, String priority) {
    setState(() {
      db.widgets.insert(
        0,
        [false, head, description, priority],
      );
    });
    db.updateDataBase();
  }

  void checkedBoxChange(bool? val, int index) {
    setState(() {
      db.widgets[index][0] = !db.widgets[index][0];
      if (val == true) {
        List widgetToMove = db.widgets.removeAt(index);
        db.widgets.add(widgetToMove);
      } else {
        List widgetToMove = db.widgets.removeAt(index);
        db.widgets.insert(0, widgetToMove);
      }
    });
    db.updateDataBase();
  }

  update(index, bool val, String head, String desc, String prio) {
    setState(() {
      db.widgets.removeAt(index);
      db.widgets.insert(
        0,
        [false, head, desc, prio],
      );
    });
    db.updateDataBase();
  }

  void deleteWidget(int index) {
    setState(() {
      db.widgets.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'To-Dos',
          style:
              GoogleFonts.openSans(fontSize: 30, fontWeight: FontWeight.w400),
        ),
      ),
      body: ListView.builder(
          itemCount: db.widgets.length,
          itemBuilder: (context, index) {
            return toDO(
                context,
                db.widgets[index][0],
                db.widgets[index][1],
                db.widgets[index][2],
                db.widgets[index][3],
                (value) => checkedBoxChange(value, index),
                () => deleteWidget(index),
                (h, n, p) => update(index, db.widgets[index][0], h, n, p));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => newtodo()),
          );
          // Call the function with the result from Page2
          addWidget(
              result['heading'], result['description'], result['priority']);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
