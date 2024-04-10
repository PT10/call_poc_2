import 'dart:convert';

import 'package:call_poc_2/viewModels/base/baseModel.dart';
import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:call_poc_2/viewModels/base/elementRenderer.dart';
import 'package:call_poc_2/viewModels/base/initActionModel.dart';
import 'package:call_poc_2/viewModels/base/iterativeItemModel.dart';
import 'package:call_poc_2/viewModels/layout/layoutBase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class GridLayout extends LayoutBase {
  final List<BaseModel>? children;
  final IterativeItemModel? itemRendererModel;
  final int numCols;

  GridLayout(super.type, super.subType, this.numCols,
      {this.children, this.itemRendererModel, super.title, super.initAction});

  factory GridLayout.fromJson(Map<String, dynamic> json) {
    return GridLayout(json["type"], json["subType"], json["numCols"],
        children: json.containsKey("children")
            ? (json["children"] as List<dynamic>)
                .map((p) => BaseModel.fromJson(p as Map<String, dynamic>))
                .toList()
            : null,
        itemRendererModel: IterativeItemModel.fromJson(
            json["itemRenderer"] as Map<String, dynamic>),
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
      //data: data,
    );
  }

  Widget _getCmp(BuildContext context, Map<String, dynamic>? respObj) {
    // List<dynamic> myData = [];
    // if (respObj != null) {
    //   //var respObj = json.decode(resp.body);
    //   myData = (respObj["data"] as List<dynamic>);
    // }
    DataModel model = Provider.of<DataModel>(context, listen: false);
    return Card(
        child: GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: numCols),
      itemCount: model.data.length,
      itemBuilder: (context, index) {
        DataModel oldModel = Provider.of<DataModel>(context, listen: false);
        DataModel newModel = DataModel(oldModel.data);
        newModel.setData(oldModel.data["data"][index]);

        return ChangeNotifierProvider<DataModel>.value(
            value: newModel,
            builder: (ctx, w) => itemRendererModel!.createItem().render(ctx));
        // BaseModel? childModel = itemRendererModel?.createItem();
        // if (childModel != null) {
        //   childModel.setData(
        //       (myData[index] as Map<String, dynamic>)..addAll(data!), context);
        //   return Card(child: childModel.render(context));
        // }

        // return Container();
      },
    ));
  }
}
