import 'package:call_poc_2/viewModels/field/actionModel.dart';
import 'package:call_poc_2/viewModels/base/initActionModel.dart';
import 'package:call_poc_2/viewModels/field/fieldBase.dart';

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

  @override
  factory LabelField.fromJson(Map<String, dynamic> json) {
    return LabelField(json["type"], json["subType"],
        label: json["label"],
        valueField: json["valueField"],
        action: json.containsKey("action")
            ? (json["action"] as List)
                .map((e) =>
                    ActionModel.fromJson(e as Map<String, dynamic>, null))
                .toList()
            : null,
        initAction: json.containsKey("initAction")
            ? InitActionModel.fromJson(
                json["initAction"] as List<Map<String, dynamic>>)
            : null);
  }
}
