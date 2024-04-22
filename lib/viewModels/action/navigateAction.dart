import 'package:call_poc_2/renderes/RendererFactory.dart';
import 'package:call_poc_2/viewModels/action/actionBase.dart';
import 'package:call_poc_2/viewModels/base/customDataModel.dart';
import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:call_poc_2/viewModels/layout/layoutBase.dart';
import 'package:call_poc_2/viewModels/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigateAction extends ActionBase {
  String pageId;
  List<dynamic>? data;

  NavigateAction(super.type, {required this.pageId, this.data});

  factory NavigateAction.fromJson(Map<String, dynamic> json) {
    return NavigateAction('navigate',
        pageId: json["pageId"], data: json["data"]);
  }

  @override
  void perform(BuildContext context, {Function? actionCallBack}) {
    DataModel componentData = Provider.of<DataModel>(context, listen: false);
    //CustomDataModel? customeModel;
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

    // if (model.customDataModel != null) {
    //   customeModel = CustomDataModel(model.customDataModel!);
    // }

    /* Widget w = MultiProvider(
        providers: skipNulls([
          ChangeNotifierProvider<DataModel>(create: (_) => DataModel(myData)),
          customeModel != null ?ChangeNotifierProvider<CustomDataModel>.value(value: customeModel) : null
        ]),
        builder: (ctx, child) => RendererFactory.getWidget(
              model.subType,
              model,
              context: context,
            )); */

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
