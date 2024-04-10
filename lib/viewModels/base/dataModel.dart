import 'package:flutter/material.dart';

class DataModel extends ChangeNotifier {
  final Map<String, dynamic> data;

  DataModel(this.data);

  void setData(Map<String, dynamic> d) {
    if (d.containsKey("latitude")) {
      d["latitude"] = d["latitude"].toString();
    }
    if (d.containsKey("longitude")) {
      d["longitude"] = d["longitude"].toString();
    }
    data.addAll(d);
    notifyListeners();
  }
}
