import 'package:call_poc_2/renderes/RendererFactory.dart';
import 'package:call_poc_2/viewModels/action/actionBase.dart';
import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:call_poc_2/viewModels/layout/layoutBase.dart';
import 'package:call_poc_2/viewModels/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class APIAction extends ActionBase {
  final String api;
  final ActionBase? onSuccess, onFailure;

  final Map<String, dynamic>? params;

  APIAction(super.type,
      {required this.api,
      required this.onSuccess,
      required this.onFailure,
      this.params});

  factory APIAction.fromJson(Map<String, dynamic> json) {
    return APIAction('navigate',
        api: json["api"],
        onSuccess: json.containsKey("onSuccess") &&
                json["onSuccess"].containsKey("action")
            ? ActionBase.fromJson(json["onSuccess"]["action"])
            : null,
        params: json["params"],
        onFailure: json.containsKey("onFailure") &&
                json["onFailure"].containsKey("action")
            ? ActionBase.fromJson(json["onFailure"]["action"])
            : null);
  }

  @override
  void perform(BuildContext context, {Function? actionCallBack}) {
    DataModel componentData = Provider.of<DataModel>(context, listen: false);
    //LayoutBase model = LayoutBase.fromJson(getPage(pageId!));
  }
}
