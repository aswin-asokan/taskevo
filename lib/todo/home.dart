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
  void addWidget(
      String head, String description, String priority, DateTime date) {
    int insertIndex = 0, startIndex = 0, endIndex = 0;
    String dateString = date.day.toString() +
        "-" +
        date.month.toString() +
        "-" +
        date.year.toString();
    if (db.widgets.isEmpty) {
      setState(() {
        db.widgets.insert(
          0,
          [false, head, description, priority, date],
        );
      });
    } else {
      if (priority == "high") {
        startIndex = 0;
      } else {
        int s = 0;
        for (int i = 0; i < db.widgets.length; i++) {
          if (db.widgets[i][3] == "high") s++;
        }
        for (int i = s; i < db.widgets.length; i++) {
          if (db.widgets[i][3] == "mid" && priority == "mid") {
            startIndex = i;
            break;
          }
          if (db.widgets[i][3] == "low" && priority == "low") {
            startIndex = i;
            break;
          }
          if (db.widgets[i][3] == "no" && priority == "no") {
            startIndex = i;
            break;
          }
        }
        int e = 0;
        for (int i = startIndex; i < db.widgets.length; i++) {
          if (db.widgets[i][3] != priority) {
            endIndex = i;
            break;
          }
        }
        for (int i = startIndex; i < endIndex; i++) {
          if (date.isAfter(db.widgets[i][4])) {
            insertIndex = i + 1;
          } else {
            break;
          }
        }
      }
    }
    print(startIndex);
    print(endIndex);
    print(insertIndex);
    setState(() {
      db.widgets.insert(
        insertIndex,
        [false, head, description, priority, date],
      );
    });
    db.updateDataBase();
  }

  void checkedBoxChange(bool? val, int index) {
    setState(() {
      db.widgets[index][0] = !db.widgets[index][0];
      if (val == true) {
        List widgetToMove = db.widgets.removeAt(index);
        db.widgets.insert(db.widgets.length, widgetToMove);
      } else {
        List widgetToMove = db.widgets.removeAt(index);
        addWidget(
            widgetToMove[1], widgetToMove[2], widgetToMove[3], widgetToMove[4]);
      }
      ;
    });
    db.updateDataBase();
  }

  update(
      index, bool val, String head, String desc, String prio, DateTime date) {
    setState(() {
      db.widgets.removeAt(index);
      db.widgets.insert(
        0,
        [false, head, desc, prio, date],
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
                db.widgets[index][4],
                (value) => checkedBoxChange(value, index),
                () => deleteWidget(index),
                (h, n, p, dT) =>
                    update(index, db.widgets[index][0], h, n, p, dT));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => newtodo()),
          );
          // Call the function with the result from Page2
          addWidget(result['heading'], result['description'],
              result['priority'], result['date']);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
