import 'package:call_poc_2/renderes/RendererFactory.dart';
import 'package:call_poc_2/viewModels/action/actionBase.dart';
import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:call_poc_2/viewModels/layout/layoutBase.dart';
import 'package:call_poc_2/viewModels/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopupAction extends ActionBase {
  String pageId;

  PopupAction(super.type, {required this.pageId});

  factory PopupAction.fromJson(Map<String, dynamic> json) {
    return PopupAction(
      'popup',
      pageId: json["pageId"],
    );
  }

  @override
  void perform(BuildContext context, {Function? actionCallBack}) {
    LayoutBase model = LayoutBase.fromJson(getPage(pageId!));
    Map<String, dynamic> myData = {};
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
  }
}
