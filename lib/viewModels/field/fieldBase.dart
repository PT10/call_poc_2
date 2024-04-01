import 'package:call_poc_2/viewModels/field/actionModel.dart';
import 'package:call_poc_2/viewModels/base/baseModel.dart';
import 'package:call_poc_2/viewModels/field/iconButtonField.dart';
import 'package:call_poc_2/viewModels/field/labelField.dart';

abstract class FieldBase extends BaseModel {
  ActionModel? action;
  FieldBase(super.type, super.subType, {this.action, super.initAction});

  factory FieldBase.fromJson(Map<String, dynamic> json) {
    switch (json["subType"]) {
      case "iconButton":
        return IconButtonField.fromJson(json);
      case "label":
        return LabelField.fromJson(json);
      default:
        return IconButtonField.fromJson(json);
    }
  }
}