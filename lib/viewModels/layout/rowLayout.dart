import 'package:call_poc_2/viewModels/base/baseModel.dart';
import 'package:call_poc_2/viewModels/base/elementRenderer.dart';
import 'package:call_poc_2/viewModels/base/initActionModel.dart';
import 'package:call_poc_2/viewModels/layout/layoutBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';

class RowLayout extends LayoutBase {
  final List<BaseModel>? children;

  RowLayout(super.type, super.subType, this.children,
      {super.title, super.initAction});

  factory RowLayout.fromJson(Map<String, dynamic> json) {
    return RowLayout(
        json["type"],
        json["subType"],
        json.containsKey("children")
            ? (json["children"] as List<dynamic>)
                .map((p) => BaseModel.fromJson(p as Map<String, dynamic>))
                .toList()
            : null,
        title: json["title"],
        initAction: json.containsKey("initAction")
            ? InitActionModel.fromJson(
                json["initAction"] as Map<String, dynamic>)
            : null);
  }

  @override
  Widget render(BuildContext context) {
    return ElementRenderer(
        getCmp: (resp) => _getCmp(context, resp), initAction: initAction);
  }

  Widget _getCmp(BuildContext context, Response? resp) {
    if (children == null) {
      return Container();
    }
    return Card(
        child: Row(
            children: children!.map((e) {
      e.setData(data); // Pass data to each child
      return Expanded(
          child: Column(children: [Expanded(child: e.render(context))]));
    }).toList()));
  }
}