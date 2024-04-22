import 'package:call_poc_2/viewModels/base/baseModel.dart';
import 'package:call_poc_2/viewModels/layout/columnLayout.dart';
import 'package:call_poc_2/viewModels/layout/formLayout.dart';
import 'package:call_poc_2/viewModels/layout/gridLayout.dart';
import 'package:call_poc_2/viewModels/layout/listLayout.dart';
import 'package:call_poc_2/viewModels/layout/popupLayout.dart';
import 'package:call_poc_2/viewModels/layout/rowLayout.dart';
import 'package:call_poc_2/viewModels/layout/scaffoldLayout.dart';
import 'package:call_poc_2/viewModels/layout/stackLayout.dart';
import 'package:call_poc_2/viewModels/utils.dart';

abstract class LayoutBase extends BaseModel {
  String? title, customDataModel;
  bool useCustomDataModel;
  LayoutBase(super.type, super.subType,
      {this.title,
      super.initAction,
      super.condition,
      this.customDataModel,
      this.useCustomDataModel = false});

  factory LayoutBase.fromJson(Map<String, dynamic> json) {
    switch (json["subType"]) {
      case "scaffold":
        return ScaffoldLayout.fromJson(json);
      case "column":
        return ColumnLayout.fromJson(json);
      case "row":
        return RowLayout.fromJson(json);
      case "grid":
        return GridLayout.fromJson(json);
      case "list":
        return ListLayout.fromJson(json);
      case "stack":
        return StackLayout.fromJson(json);
      case "popup":
        return PopupLayout.fromJson(json);
      case "form":
        return FormLayout.fromJson(json);
      case "page":
        String page = json["pageId"];
        LayoutBase baseModel = LayoutBase.fromJson(getPage(page));
        baseModel.condition = json["condition"];
        return baseModel;
      default:
        return ColumnLayout.fromJson(json);
    }
  }
}
