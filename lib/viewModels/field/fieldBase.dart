import 'package:call_poc_2/viewModels/action/actionBase.dart';
import 'package:call_poc_2/viewModels/base/baseModel.dart';
import 'package:call_poc_2/viewModels/field/agoraCallPage.dart';
import 'package:call_poc_2/viewModels/field/dropDownField.dart';
import 'package:call_poc_2/viewModels/field/iconButtonField.dart';
import 'package:call_poc_2/viewModels/field/labelField.dart';
import 'package:call_poc_2/viewModels/field/submitButtonField.dart';
import 'package:call_poc_2/viewModels/field/textButtonField.dart';
import 'package:call_poc_2/viewModels/field/textField.dart';

abstract class FieldBase extends BaseModel {
  List<ActionBase>? action;
  FieldBase(super.type, super.subType,
      {this.action, super.initAction, super.condition});

  @override
  factory FieldBase.fromJson(Map<String, dynamic> json) {
    switch (json["subType"]) {
      case "iconButton":
        return IconButtonField.fromJson(json);
      case "dropDown":
        return DropDownField.fromJson(json);
      case "textButton":
        return TextButtonField.fromJson(json);
      case "label":
        return LabelField.fromJson(json);
      case "agoraCallPage":
        return AgoraCallPage.fromJson(json);
      case "text":
        return TextFieldCustom.fromJson(json);
      case "submit":
        return SubmitButtonField.fromJson(json);
      default:
        return IconButtonField.fromJson(json);
    }
  }
}
