import 'package:call_poc_2/viewModels/base/baseModel.dart';
import 'package:call_poc_2/viewModels/layout/columnLayout.dart';
import 'package:call_poc_2/viewModels/layout/gridLayout.dart';
import 'package:call_poc_2/viewModels/layout/listLayout.dart';
import 'package:call_poc_2/viewModels/layout/popupLayout.dart';
import 'package:call_poc_2/viewModels/layout/rowLayout.dart';
import 'package:call_poc_2/viewModels/layout/stackLayout.dart';

abstract class LayoutBase extends BaseModel {
  String? title;
  LayoutBase(super.type, super.subType, {this.title, super.initAction});

  factory LayoutBase.fromJson(Map<String, dynamic> json) {
    switch (json["subType"]) {
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
      default:
        return ColumnLayout.fromJson(json);
    }
  }
}
