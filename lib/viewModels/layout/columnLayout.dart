import 'package:call_poc_2/renderes/RendererFactory.dart';
import 'package:call_poc_2/viewModels/base/baseModel.dart';
import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:call_poc_2/viewModels/base/initActionModel.dart';
import 'package:call_poc_2/viewModels/layout/layoutBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class ColumnLayout extends LayoutBase {
  final List<BaseModel>? children;

  ColumnLayout(super.type, super.subType, this.children,
      {super.title,
      super.initAction,
      super.condition,
      super.customDataModel,
      super.consumeCustomDataModel});

  factory ColumnLayout.fromJson(Map<String, dynamic> json) {
    return ColumnLayout(
        json["type"],
        json["subType"],
        json.containsKey('children')
            ? (json["children"] as List<dynamic>)
                .map((p) => BaseModel.fromJson(p as Map<String, dynamic>))
                .toList()
            : null,
        title: json["title"],
        initAction: json.containsKey("initAction")
            ? InitActionModel.fromJson(
                json["initAction"] as List<Map<String, dynamic>>)
            : null,
        condition: json["condition"],
        customDataModel: json["customDataModel"],
        consumeCustomDataModel: json["consumeCustomDataModel"] ?? false);
  }
}
