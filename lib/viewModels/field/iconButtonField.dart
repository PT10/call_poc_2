import 'package:call_poc_2/viewModels/field/actionModel.dart';
import 'package:call_poc_2/viewModels/base/initActionModel.dart';
import 'package:call_poc_2/viewModels/field/fieldBase.dart';
import 'package:call_poc_2/viewModels/base/elementRenderer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class IconButtonField extends FieldBase {
  String? iconUrl, buttonText, buttonTextFieldInData;

  IconButtonField(
    super.type,
    super.subType, {
    this.iconUrl,
    this.buttonText,
    this.buttonTextFieldInData,
    super.action,
    super.initAction,
  });

  factory IconButtonField.fromJson(Map<String, dynamic> json) {
    return IconButtonField(json["type"], json["subType"],
        iconUrl: json["iconUrl"],
        buttonText: json["buttonText"],
        buttonTextFieldInData: json["buttonTextFieldInData"],
        action: json.containsKey("action")
            ? ActionModel.fromJson(json["action"] as Map<String, dynamic>, null)
            : null,
        initAction: json.containsKey("initAction")
            ? InitActionModel.fromJson(
                json["initAction"] as Map<String, dynamic>)
            : null);
  }

  @override
  Widget render(BuildContext context) {
    return ElementRenderer(
        getCmp: (resp) => _getCmp(context, resp), initAction: initAction);
  }

  @override
  void setData(Map<String, dynamic>? d) {
    super.setData(d);
    action?.setData(
        d); // Set same data for action too so that it can be passsed to next page when the action is performed.
  }

  Widget _getCmp(BuildContext context, Response? resp) {
    return TextButton.icon(
      onPressed: () {
        if (action != null) {
          action!.perform(context);
        }
      },
      icon: const Icon(Icons.plus_one),
      label: Text(buttonText ??
          (data != null && data!.containsKey(buttonTextFieldInData)
              ? data![buttonTextFieldInData]
              : '')),
    );
  }
}
