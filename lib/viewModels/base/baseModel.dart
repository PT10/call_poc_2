import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:call_poc_2/viewModels/base/initActionModel.dart';
import 'package:call_poc_2/viewModels/field/fieldBase.dart';
import 'package:call_poc_2/viewModels/layout/layoutBase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class BaseModel {
  final String type, subType;
  final InitActionModel? initAction;
  Map<String, dynamic>? condition;
  int? flex;
  //Map<String, dynamic> data = {};

  BaseModel(
    this.type,
    this.subType, {
    this.initAction,
    this.condition,
  });

  factory BaseModel.fromJson(Map<String, dynamic> json) {
    if (json["type"] == "layout") {
      return LayoutBase.fromJson(json)..flex = json["flex"];
    } else if (json["type"] == "field") {
      return FieldBase.fromJson(json)..flex = json["flex"];
    }
    return LayoutBase.fromJson(json);
  }

  void setData(Map<String, dynamic>? d, BuildContext context) {
    if (d == null) {
      return;
    }

    DataModel dataModel = Provider.of<DataModel>(context, listen: false);
    dataModel.setData(d);

    //data.addAll(d);
  }

  Widget render(BuildContext context, {Function? onAction}) {
    return Center(
      child: Text("This should not be shown"),
    );
  }
}
