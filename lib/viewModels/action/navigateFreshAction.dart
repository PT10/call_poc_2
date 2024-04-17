import 'package:call_poc_2/renderes/RendererFactory.dart';
import 'package:call_poc_2/viewModels/action/actionBase.dart';
import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:call_poc_2/viewModels/layout/layoutBase.dart';
import 'package:call_poc_2/viewModels/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigateFreshAction extends ActionBase {
  String pageId;
  List<dynamic>? data;

  NavigateFreshAction(super.type, {required this.pageId, this.data});

  factory NavigateFreshAction.fromJson(Map<String, dynamic> json) {
    return NavigateFreshAction('navigateFresh',
        pageId: json["pageId"], data: json["data"]);
  }

  @override
  void perform(BuildContext context, {Function? actionCallBack}) {
    DataModel componentData = Provider.of<DataModel>(context, listen: false);
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
  }
}
