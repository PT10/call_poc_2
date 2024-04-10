import 'package:call_poc_2/viewModels/base/baseModel.dart';
import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:call_poc_2/viewModels/layout/layoutBase.dart';
import 'package:call_poc_2/viewModels/utils.dart';
import 'package:call_poc_2/views/patientFlow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  void setData(Map<String, dynamic>? d, BuildContext context) {
    if (d == null) {
      return;
    }
    DataModel componentData = Provider.of<DataModel>(context, listen: false);
    componentData.setData(d);
    // if (parentData != null) {
    //   parentData!.addAll(d);
    // } else {
    //   parentData = d;
    // }
  }

  void perform(BuildContext context) {
    LayoutBase model = LayoutBase.fromJson(getPage(pageId!));
    DataModel componentData = Provider.of<DataModel>(context, listen: false);
    Map<String, dynamic> myData = {};
    data?.forEach((element) {
      if (element is Map<String, dynamic>) {
        myData![element["newKey"]] = componentData.data[element["oldKey"]];
      } else {
        myData![element] = componentData.data[element];
      }
    });

    switch (type) {
      case "navigate":
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Scaffold(
              appBar: AppBar(
                title: Text(model.title ?? ''),
              ),
              body: ChangeNotifierProvider<DataModel>(
                  create: (_) => DataModel(myData),
                  builder: (ctx, child) => model.render(ctx))),
        ));
        break;
      case "popup":
        showDialog(
          context: context,
          builder: (context) {
            return ChangeNotifierProvider<DataModel>(
                create: (_) => DataModel(myData),
                builder: (ctx, child) => model.render(ctx));
          },
        );
      default:
    }
  }
}
