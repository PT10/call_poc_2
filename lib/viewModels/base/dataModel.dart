import 'package:flutter/material.dart';

class DataModel extends ChangeNotifier {
  final Map<String, dynamic> data;

  DataModel(this.data);

  void setData(Map<String, dynamic> d) {
    data.addAll(d);
    notifyListeners();
  }
}
