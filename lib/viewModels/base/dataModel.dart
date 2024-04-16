import 'package:flutter/material.dart';

class DataModel extends ChangeNotifier {
  final Map<String, dynamic> data;

  DataModel(this.data);

  void setData(Map<String, dynamic> d) {
    data.addAll(d);
    if (d.containsKey("data") && d["data"] is Map<String, dynamic>) {
      data.addAll(d["data"]);
    }
    notifyListeners();
  }
}
