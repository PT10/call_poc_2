import 'package:call_poc_2/viewModels/field/actionModel.dart';
import 'package:call_poc_2/viewModels/base/initActionModel.dart';
import 'package:call_poc_2/viewModels/field/fieldBase.dart';

class SubmitButtonField extends FieldBase {
  String? iconUrl, buttonText, buttonTextFieldInData;
  InitActionModel submitAction;

  SubmitButtonField(super.type, super.subType, this.submitAction,
      {this.iconUrl,
      this.buttonText,
      this.buttonTextFieldInData,
      super.action,
      super.initAction,
      super.condition});

  @override
  factory SubmitButtonField.fromJson(Map<String, dynamic> json) {
    return SubmitButtonField(
        json["type"],
        json["subType"],
        InitActionModel.fromJson(
            [json["submitAction"] as Map<String, dynamic>]),
        iconUrl: json["iconUrl"],
        buttonText: json["buttonText"],
        buttonTextFieldInData: json["buttonTextFieldInData"],
        action: json.containsKey("action")
            ? (json["action"] as List)
                .map((e) =>
                    ActionModel.fromJson(e as Map<String, dynamic>, null))
                .toList()
            : null,
        initAction: json.containsKey("initAction")
            ? InitActionModel.fromJson(
                json["initAction"] as List<Map<String, dynamic>>)
            : null,
        condition: json["condition"]);
  }
}
