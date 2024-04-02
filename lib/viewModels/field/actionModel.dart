import 'package:call_poc_2/viewModels/base/baseModel.dart';
import 'package:call_poc_2/viewModels/layout/layoutBase.dart';
import 'package:call_poc_2/viewModels/utils.dart';
import 'package:call_poc_2/views/patientFlow.dart';
import 'package:flutter/material.dart';

class ActionModel {
  String type;
  String? pageId;
  List<dynamic>? data;
  Map<String, dynamic>? parentData;

  ActionModel(this.type, {this.pageId, this.data, this.parentData});

  factory ActionModel.fromJson(
      Map<String, dynamic> json, Map<String, dynamic>? data) {
    return ActionModel(json["type"],
        pageId: json["pageId"],
        data: List<dynamic>.from(json["data"] ?? []),
        parentData: data);
  }

  void setData(Map<String, dynamic>? d) {
    if (d == null) {
      return;
    }
    if (parentData != null) {
      parentData!.addAll(d);
    } else {
      parentData = d;
    }
  }

  void perform(BuildContext context) {
    LayoutBase model = LayoutBase.fromJson(getPage(pageId!));
    model.data = {};
    data?.forEach((element) {
      if (element is Map<String, dynamic>) {
        model.data![element["newKey"]] = parentData?[element["oldKey"]];
      } else {
        model.data![element] = parentData?[element];
      }
    });

    switch (type) {
      case "navigate":
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Scaffold(
              appBar: AppBar(
                title: Text(model.title ?? ''),
              ),
              body: model.render(context)),
        ));
        break;
      case "popup":
        showDialog(
          context: context,
          builder: (context) {
            return model.render(context);
          },
        );
      default:
    }
  }
}
