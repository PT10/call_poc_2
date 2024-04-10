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

class ListLayout extends LayoutBase {
  final List<BaseModel>? children;
  final IterativeItemModel? itemRendererModel;

  ListLayout(super.type, super.subType,
      {this.children, this.itemRendererModel, super.title, super.initAction});

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
    List<dynamic> myData = [];
    if (respObj != null) {
      // var respObj = json.decode(resp.body);
      if (respObj["status"] == 1) {
        myData = (respObj["data"] as List<dynamic>);
      } else {
        return Center(
          child: Text(respObj["message"]),
        );
      }
    }
    return ListView.builder(
      itemCount: myData.isNotEmpty ? myData.length : children?.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (itemRendererModel != null) {
          DataModel oldModel = Provider.of<DataModel>(context, listen: false);
          DataModel newModel = DataModel(oldModel.data);
          newModel.setData(oldModel.data["data"][index]);

          return ChangeNotifierProvider<DataModel>.value(
              value: newModel,
              builder: (ctx, w) => SizedBox(
                  height: 100,
                  child: Card(
                      child: itemRendererModel?.createItem().render(ctx))));

          // BaseModel? childModel = itemRendererModel?.createItem();
          // if (childModel != null) {
          //   return SizedBox(
          //       height: 100, child: Card(child: childModel.render(context)));
          // }

          // return Container();
        } else if (children != null) {
          return children![index].render(context);
        } else {
          return const Center(
            child: Text("No item found"),
          );
        }
      },
    );
  }
}
