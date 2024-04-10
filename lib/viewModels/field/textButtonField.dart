import 'package:call_poc_2/viewModels/base/dataModel.dart';
import 'package:call_poc_2/viewModels/field/actionModel.dart';
import 'package:call_poc_2/viewModels/base/initActionModel.dart';
import 'package:call_poc_2/viewModels/field/fieldBase.dart';
import 'package:call_poc_2/renderes/elementRenderer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class TextButtonField extends FieldBase {
  String? iconUrl, buttonText, buttonTextFieldInData;

  TextButtonField(
    super.type,
    super.subType, {
    this.iconUrl,
    this.buttonText,
    this.buttonTextFieldInData,
    super.action,
    super.initAction,
  });

  @override
  factory TextButtonField.fromJson(Map<String, dynamic> json) {
    return TextButtonField(json["type"], json["subType"],
        iconUrl: json["iconUrl"],
        buttonText: json["buttonText"],
        buttonTextFieldInData: json["buttonTextFieldInData"],
        action: json.containsKey("action")
            ? ActionModel.fromJson(json["action"] as Map<String, dynamic>, null)
            : null,
        initAction: json.containsKey("initAction")
            ? InitActionModel.fromJson(
                json["initAction"] as List<Map<String, dynamic>>)
            : null);
  }

  // @override
  // Widget render(BuildContext context, {Function? onAction}) {
  //   return ElementRenderer(
  //     'textButton', this,
  //     getCmp: (resp) => _getCmp(context, resp, onAction: onAction),
  //     initAction: initAction,
  //     //data: data,
  //   );
  // }

  // @override
  // void setData(Map<String, dynamic>? d) {
  //   super.setData(d);
  //   action?.setData(
  //       d); // Set same data for action too so that it can be passsed to next page when the action is performed.
  // }

  Widget _getCmp(BuildContext context, Map<String, dynamic>? resp,
      {Function? onAction}) {
    DataModel d = Provider.of<DataModel>(context, listen: false);
    return TextButton(
      onPressed: () {
        if (onAction != null) {
          onAction(); // Action performed on the parent component.. e.g. close popup window
        }
        if (action != null) {
          //action!.setData(resp);
          //action!.perform(context);
          //DataModel d = Provider.of<DataModel>(context, listen: false);
          //d.setData(resp ?? {});
          action!.perform(context);
        }
      },
      child: Text(buttonText ??
          (d.data.containsKey(buttonTextFieldInData)
              ? d.data[buttonTextFieldInData]
              : '')),
    );
  }
}
