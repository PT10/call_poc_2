import 'package:call_poc_2/viewModels/base/baseModel.dart';
import 'package:call_poc_2/viewModels/layout/layoutBase.dart';
import 'package:call_poc_2/viewModels/utils.dart';
import 'package:call_poc_2/views/patientFlow.dart';
import 'package:flutter/material.dart';

class IterativeItemModel {
  final String pageId;
  final List<dynamic>? params;

  IterativeItemModel(this.pageId, {this.params});

  factory IterativeItemModel.fromJson(Map<String, dynamic> json) {
    return IterativeItemModel(json["pageId"],
        params: json.containsKey("params")
            ? (json["params"] as List<dynamic>)
            : null);
  }

  BaseModel createItem() {
    return BaseModel.fromJson(getPage(pageId));
  }
}
