import 'package:call_poc_2/viewModels/base/initActionModel.dart';
import 'package:call_poc_2/viewModels/field/fieldBase.dart';
import 'package:call_poc_2/viewModels/layout/layoutBase.dart';
import 'package:flutter/material.dart';

abstract class BaseModel {
  final String type, subType;
  final InitActionModel? initAction;
  Map<String, dynamic>? data;

  BaseModel(this.type, this.subType, {this.data, this.initAction});

  factory BaseModel.fromJson(Map<String, dynamic> json) {
    if (json["type"] == "layout") {
      return LayoutBase.fromJson(json);
    } else if (json["type"] == "field") {
      return FieldBase.fromJson(json);
    }
    return LayoutBase.fromJson(json);
  }

  void setData(Map<String, dynamic>? d) {
    data = d;
  }

  Widget render(BuildContext context);
}
