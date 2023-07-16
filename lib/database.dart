import 'package:hive_flutter/adapters.dart';

class database {
  List widgets = [];

  // reference our box
  final _myBox = Hive.box('mybox');

  // run this method if this is the 1st time ever opening this app
  void createInitialData() {
    widgets = [];
  }

  // load the data from database
  void loadData() {
    widgets = _myBox.get("TODOLIST");
  }

  // update the database
  void updateDataBase() {
    _myBox.put("TODOLIST", widgets);
  }
}
