import 'package:call_poc_2/renderes/RendererFactory.dart';
import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:call_poc_2/settings.dart';
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
  String? variable;

  ActionModel(this.type,
      {this.pageId, this.data, this.parentData, this.variable});

  factory ActionModel.fromJson(
      Map<String, dynamic> json, Map<String, dynamic>? data) {
    return ActionModel(json["type"],
        pageId: json["pageId"],
        data: List<dynamic>.from(json["data"] ?? []),
        variable: json["var"],
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

  void perform(BuildContext context, {Function? actionCallBack}) {
    DataModel componentData = Provider.of<DataModel>(context, listen: false);
    if (type == 'memoryUpdate') {
      globalVariables[variable!] = componentData.data[variable];
      return;
    } else if (type == 'refresh' && actionCallBack != null) {
      actionCallBack("refresh");
      return;
    } else if (type == 'close' && actionCallBack != null) {
      actionCallBack("close");
      return;
    }
    LayoutBase model = LayoutBase.fromJson(getPage(pageId!));

    Map<String, dynamic> myData = {};
    data?.forEach((element) {
      if (element is Map<String, dynamic>) {
        if (element.containsKey("newKey") && element.containsKey("oldKey")) {
          myData![element["newKey"]] = componentData.data[element["oldKey"]];
        }
      } else {
        myData![element] = componentData.data[element];
      }
    });

    switch (type) {
      case "navigate":
        Widget w = ChangeNotifierProvider<DataModel>(
            create: (_) => DataModel(myData),
            builder: (ctx, child) => RendererFactory.getWidget(
                  model.subType,
                  model,
                  context: context,
                ));
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => model.subType == 'scaffold'
              ? w
              : Scaffold(
                  appBar: AppBar(
                    title: Text(model.title ?? ''),
                  ),
                  body: w),
        ));
        break;
      case "navigateFresh":
        Widget w = ChangeNotifierProvider<DataModel>(
            create: (_) => DataModel(myData),
            builder: (ctx, child) => RendererFactory.getWidget(
                  model.subType,
                  model,
                  context: context,
                ));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => model.subType == 'scaffold'
                  ? w
                  : Scaffold(
                      appBar: AppBar(
                        title: Text(model.title ?? ''),
                      ),
                      body: w),
            ),
            (Route<dynamic> route) => false);
        break;
      case "popup":
        showDialog(
          context: context,
          builder: (context) {
            return ChangeNotifierProvider<DataModel>(
                create: (_) => DataModel(myData),
                builder: (ctx, child) => RendererFactory.getWidget(
                      model.subType,
                      model,
                      context: ctx,
                    ));
          },
        );
      default:
    }
  }
}
