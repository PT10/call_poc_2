import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDataModel extends ChangeNotifier {
  List<Map<String, dynamic>>? data;
  final String? name;

  CustomDataModel(this.name, {this.data});

  void addData(Map<String, dynamic> d) {
    data ??= [];
    data!.add(d);
    notifyListeners();
  }

  void removeData(String idField, String idFieldValue) {
    data?.removeWhere((element) => element[idField] == idFieldValue);
    notifyListeners();
  }

  bool contains(String idField, String idFieldValue) {
    if (data == null) {
      return false;
    }
    return data
            ?.firstWhereOrNull((element) => element[idField] == idFieldValue) !=
        null;
  }
}
