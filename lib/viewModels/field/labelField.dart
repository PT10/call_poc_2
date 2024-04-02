import 'dart:convert';

import 'package:call_poc_2/viewModels/field/actionModel.dart';
import 'package:call_poc_2/viewModels/base/initActionModel.dart';
import 'package:call_poc_2/viewModels/field/fieldBase.dart';
import 'package:call_poc_2/viewModels/base/elementRenderer.dart';
import 'package:call_poc_2/viewModels/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class LabelField extends FieldBase {
  String? label, valueField;

  LabelField(
    super.type,
    super.subType, {
    this.label,
    this.valueField,
    super.action,
    super.initAction,
  });

  factory LabelField.fromJson(Map<String, dynamic> json) {
    return LabelField(json["type"], json["subType"],
        label: json["label"],
        valueField: json["valueField"],
        action: json.containsKey("action")
            ? ActionModel.fromJson(json["action"] as Map<String, dynamic>, null)
            : null,
        initAction: json.containsKey("initAction")
            ? InitActionModel.fromJson(
                json["initAction"] as List<Map<String, dynamic>>)
            : null);
  }

  @override
  Widget render(BuildContext context, {Function? onAction}) {
    return ElementRenderer(
      getCmp: (resp) => _getCmp(context, resp),
      initAction: initAction,
      data: data,
    );
  }

  Widget _getCmp(BuildContext context, Response? resp) {
    if (resp != null) {
      data?.addAll(json.decode(resp.body));
    }
    return Wrap(
      children: skipNulls([
        label != null ? Text(label!) : null,
        valueField != null ? Text(data?[valueField]?.toString() ?? '') : null
      ]),
    );
  }
}
