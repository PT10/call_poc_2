import 'package:call_poc_2/viewModels/action/apiAction.dart';
import 'package:call_poc_2/viewModels/action/closeAction.dart';
import 'package:call_poc_2/viewModels/action/memoryUpdateAction.dart';
import 'package:call_poc_2/viewModels/action/navigateAction.dart';
import 'package:call_poc_2/viewModels/action/navigateFreshAction.dart';
import 'package:call_poc_2/viewModels/action/popupAction.dart';
import 'package:call_poc_2/viewModels/action/refreshAction.dart';
import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class ActionBase {
  String type;
  List<dynamic>? data;

  ActionBase(this.type);

  factory ActionBase.fromJson(Map<String, dynamic> json) {
    switch (json["type"]) {
      case "navigate":
        return NavigateAction.fromJson(json);
      case "navigateFresh":
        return NavigateFreshAction.fromJson(json);
      case "popup":
        return PopupAction.fromJson(json);
      case "memoryUpdate":
        return MemoryUpdateAction.fromJson(json);
      case "refresh":
        return RefreshAction.fromJson(json);
      case "close":
        return CloseAction.fromJson(json);
      case "api":
        return APIAction.fromJson(json);
      default:
        return NavigateAction.fromJson(json);
    }
  }

  void perform(BuildContext context, {Function? actionCallBack});

  void setData(Map<String, dynamic>? d, BuildContext context) {
    if (d == null) {
      return;
    }
    DataModel componentData = Provider.of<DataModel>(context, listen: false);
    componentData.setData(d);
  }
}
