import 'dart:convert';

import 'package:call_poc_2/viewModels/base/baseModel.dart';
import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:call_poc_2/viewModels/base/initActionModel.dart';
import 'package:call_poc_2/viewModels/base/iterativeItemModel.dart';
import 'package:call_poc_2/viewModels/layout/layoutBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class ListLayout extends LayoutBase {
  final List<BaseModel>? children;
  final IterativeItemModel? itemRendererModel;
  final bool horizontal;
  final String emptyText;

  ListLayout(super.type, super.subType,
      {this.children,
      this.itemRendererModel,
      super.title,
      super.initAction,
      super.condition,
      super.useCustomDataModel,
      this.horizontal = false,
      this.emptyText = "No Items to show"});

  factory ListLayout.fromJson(Map<String, dynamic> json) {
    return ListLayout(json["type"], json["subType"],
        children: json.containsKey("children")
            ? (json["children"] as List<dynamic>)
                .map((p) => BaseModel.fromJson(p as Map<String, dynamic>))
                .toList()
            : null,
        itemRendererModel: json.containsKey("itemRenderer")
            ? IterativeItemModel.fromJson(
                json["itemRenderer"] as Map<String, dynamic>)
            : null,
        title: json["title"],
        initAction: json.containsKey("initAction")
            ? InitActionModel.fromJson(
                json["initAction"] as List<Map<String, dynamic>>)
            : null,
        condition: json["condition"],
        useCustomDataModel: json["useCustomDataModel"] ?? false,
        horizontal: json["horizontal"] ?? false,
        emptyText: json["emptyText"] ?? "No items to show");
  }
}
