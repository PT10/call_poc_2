import 'package:call_poc_2/viewModels/field/actionModel.dart';
import 'package:call_poc_2/viewModels/base/initActionModel.dart';
import 'package:call_poc_2/viewModels/field/fieldBase.dart';

class DropDownField extends FieldBase {
  final String id;
  final String? buttonText, buttonTextFieldInData;
  final List<Map<String, dynamic>> values;
  final String? value;

  DropDownField(
    super.type,
    super.subType,
    this.id, {
    this.values = const [],
    this.value,
    this.buttonText,
    this.buttonTextFieldInData,
    super.action,
    super.initAction,
  });

  @override
  factory DropDownField.fromJson(Map<String, dynamic> json) {
    return DropDownField(json["type"], json["subType"], json["id"],
        values: json["values"] as List<Map<String, dynamic>>,
        value: json["value"],
        buttonText: json["buttonText"],
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
