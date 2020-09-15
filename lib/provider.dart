import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TheData extends ChangeNotifier {
  //1) stores the selectedDate
  String _onSelectedDate =
      DateFormat('d-MMMM').format(DateTime.now()).toLowerCase();
  String get onSelectedDate => _onSelectedDate;
  set onSelectedDate(String val) {
    _onSelectedDate = val;
    notifyListeners();
  }

  //2) store the selectedDate with Year, month, and date in the database
  String _databaseSelectedDate =
      DateFormat('y-MM-dd').format(DateTime.now()).toString();
  String get databaseSelectedDate => _databaseSelectedDate;
  set databaseSelectedDate(String val) {
    _databaseSelectedDate = val;
    notifyListeners();
  }

  //3)adding event variable
  bool _addEvent = false;
  bool get addEvent => _addEvent;
  set addEvent(bool val) {
    _addEvent = val;
    notifyListeners();
  }

  //3-3) switiching the addEvent value
  addEventSwitch() {
    addEvent = !addEvent;
    notifyListeners();
  }

  //4) todays tasks number
  List _todaysTaskNumber = [];
  List get todaysTaskNumber => _todaysTaskNumber;
  set todaysTaskNumber(List val) {
    _todaysTaskNumber = val;
    notifyListeners();
  }
}
