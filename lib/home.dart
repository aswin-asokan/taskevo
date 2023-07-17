import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:todo/database.dart';
import 'package:todo/widgets.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

TextEditingController controller1 = TextEditingController();

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
  void addWidget(String head) {
    setState(() {
      db.widgets.insert(
        0,
        [false, head],
      );
    });
    db.updateDataBase();
  }

  void showBottom(BuildContext context) {
    late String h;
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: 200,
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close)),
                        Text(
                          'New To-Do',
                          style: GoogleFonts.openSans(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {
                              addWidget(h);
                              controller1.clear();
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.check)),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      style: GoogleFonts.openSans(),
                      controller: controller1,
                      autofocus: true,
                      onChanged: (value) {
                        h = controller1.text.toString();
                      },
                      decoration: InputDecoration(
                          hintText: 'New to-do',
                          hintStyle: GoogleFonts.openSans(),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
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

  void showBottomUp(int index, BuildContext context) {
    String e = db.widgets[index][1].toString();
    TextEditingController controller2 = TextEditingController(text: e);
    late String u;

    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: 200,
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close)),
                        Text(
                          'Edit To-Do',
                          style: GoogleFonts.openSans(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                db.widgets[index][1] = u.toString();
                              });
                              db.updateDataBase();
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.check)),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      style: GoogleFonts.openSans(),
                      controller: controller2,
                      autofocus: true,
                      onChanged: (value) {
                        u = controller2.text.toString();
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void deleteToDo(int index) {
    setState(() {
      db.widgets.removeAt(index);
    });
    db.updateDataBase();
  }

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
                (value) => checkedBoxChange(value, index),
                () => deleteToDo(index),
                () => showBottomUp(index, context));
          }),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {
          showBottom(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
