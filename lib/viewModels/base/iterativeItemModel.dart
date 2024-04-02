import 'package:call_poc_2/viewModels/base/baseModel.dart';
import 'package:call_poc_2/viewModels/layout/layoutBase.dart';
import 'package:call_poc_2/viewModels/utils.dart';
import 'package:call_poc_2/views/patientFlow.dart';
import 'package:flutter/material.dart';

class IterativeItemModel {
  final String pageId;
  final List<dynamic>? params;
  final List<dynamic>? data;

  IterativeItemModel(this.pageId, {this.params, this.data});

  factory IterativeItemModel.fromJson(Map<String, dynamic> json) {
    return IterativeItemModel(json["pageId"],
        data: json.containsKey("data") ? (json["data"] as List<dynamic>) : null,
        params: json.containsKey("params")
            ? (json["params"] as List<dynamic>)
            : null);
  }

  BaseModel createItem() {
    // Map<String, dynamic> myData = {};
    // if (parentData != null) {
    //   data?.forEach((element) {
    //     myData[element] = parentData[element];
    //   });
    // }
    return BaseModel.fromJson(getPage(pageId));
  }
}
