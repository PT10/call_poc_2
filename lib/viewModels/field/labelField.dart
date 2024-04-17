import 'package:call_poc_2/viewModels/action/actionBase.dart';
import 'package:call_poc_2/viewModels/base/initActionModel.dart';
import 'package:call_poc_2/viewModels/field/fieldBase.dart';

class LabelField extends FieldBase {
  String? label, valueField;

  LabelField(super.type, super.subType,
      {this.label,
      this.valueField,
      super.action,
      super.initAction,
      super.condition});

  @override
  factory LabelField.fromJson(Map<String, dynamic> json) {
    return LabelField(json["type"], json["subType"],
        label: json["label"],
        valueField: json["valueField"],
        action: json.containsKey("action")
            ? (json["action"] as List)
                .map((e) => ActionBase.fromJson(e as Map<String, dynamic>))
                .toList()
            : null,
        initAction: json.containsKey("initAction")
            ? InitActionModel.fromJson(
                json["initAction"] as List<Map<String, dynamic>>)
            : null,
        condition: json["condition"]);
  }
}
