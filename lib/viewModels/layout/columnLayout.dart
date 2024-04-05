import 'package:call_poc_2/viewModels/base/baseModel.dart';
import 'package:call_poc_2/viewModels/base/elementRenderer.dart';
import 'package:call_poc_2/viewModels/base/initActionModel.dart';
import 'package:call_poc_2/viewModels/layout/layoutBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';

class ColumnLayout extends LayoutBase {
  final List<BaseModel>? children;

  ColumnLayout(super.type, super.subType, this.children,
      {super.title, super.initAction});

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
            : null);
  }

  @override
  Widget render(BuildContext context, {Function? onAction}) {
    return ElementRenderer(
      getCmp: (resp) => _getCmp(context, resp),
      initAction: initAction,
      data: data,
    );
  }

  Widget _getCmp(BuildContext context, Map<String, dynamic>? resp) {
    if (children == null) {
      return Container();
    }
    return Column(
        children: children!.map((e) {
      e.setData(data); // Pass data to each child
      return Expanded(
          child:
              Card(child: Row(children: [Expanded(child: e.render(context))])));
    }).toList());
  }
}
